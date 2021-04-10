//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Ania on 10/04/2021.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    private let savekey = "Favorties"
    
    init() {
        self.resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        
    }
}
