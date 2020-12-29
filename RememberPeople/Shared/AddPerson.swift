//
//  AddPerson.swift
//  RememberPeople
//
//  Created by Ania on 29/12/2020.
//

import SwiftUI

struct AddPerson: View {
    
    var peopleArray: [Person]
    var inputImage: UIImage
    let locationFetcher = LocationFetcher()
    
    @State private var newPersonName: String = ""
    @State private var people = [Person]()
    
    var body: some View {
        VStack {
            Image(uiImage: inputImage)
                .resizable()
                .scaledToFit()
            TextField("Enter person name", text: $newPersonName)
                .padding()
            HStack {
                Button("Save") {
                    saveNewPerson()
                }
                .greenButton()
                Button("Dismiss") {
                    newPersonName = ""
                }
                .greenButton()
            }
        }
        .onAppear(perform: {
            self.locationFetcher.start()
        })
    }
    
    func saveNewPerson() {
        if newPersonName.isEmpty {
            print("Name cannot be empty - show alert for that")
            return
        }
        
        let imageSaver = ImageSaver()
        let fileName = newPersonName + String(Date().timeIntervalSince1970)
        print("New file name \(fileName)")
        
        let location = self.locationFetcher.lastKnownLocation
        
        imageSaver.successHandler = {
            print("Success")
            let newPerson = Person(name: newPersonName, imageURL: fileName, longitude: location?.longitude, latitude: location?.latitude)
            self.people = peopleArray
            people.append(newPerson)
            self.saveData()
            self.newPersonName = ""
        }
        
        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        
        imageSaver.writeToDisk(image: inputImage, name: fileName)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveData() {
        let filename = getDocumentsDirectory().appendingPathComponent("People")
        
        do {
            let data = try JSONEncoder().encode(self.people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
}

struct AddPerson_Previews: PreviewProvider {
    static var previews: some View {
        AddPerson(peopleArray: [Person](), inputImage: UIImage(imageLiteralResourceName: "person_example"))
    }
}
