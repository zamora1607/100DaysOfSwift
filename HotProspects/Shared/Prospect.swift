//
//  Prospect.swift
//  HotProspects
//
//  Created by Ania on 02/01/2021.
//

import SwiftUI

class Prospect: Identifiable, Codable, Comparable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name == rhs.name && lhs.id == rhs.id && lhs.emailAddress == rhs.emailAddress
    }
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    static let saveKey = "SavedData"
    
    init() {
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = directory.appendingPathComponent(Self.saveKey)
        do {
            let data = try Data(contentsOf:url)
            let peopleArray = try JSONDecoder().decode([Prospect].self, from: data)
            self.people = peopleArray
            return
        } catch {
            print("Cannot decode data")
        }
        
        self.people = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            do {
                let url = getUserDirectory().appendingPathComponent(Self.saveKey)
                try encoded.write(to: url, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data")
            }
        }
    }
    
    private func getUserDirectory() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0]
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
