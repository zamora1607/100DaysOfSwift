//
//  ContentView.swift
//  Shared
//
//  Created by Ania on 28/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var people = [Person]()
    @State private var showImagePicker = false
    @State private var uiImage: UIImage?
    @State private var newPersonName: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if (uiImage != nil) { //should be separate view
                    Image(uiImage: uiImage!)
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
                            uiImage = nil
                            newPersonName = ""
                        }
                        .greenButton()
                    }
                } else {
                    Button("Add new") {
                        showImagePicker = true
                    }
                    .greenButton()
                    List(people, id: \.uuid) { person in
                        NavigationLink(destination: PersonView(person: person)) {
                            Text(person.name)
                        }
                    }
                }
            }.navigationBarTitle(Text("New people"))
        }
        .onAppear(perform: loadData)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$uiImage)
        }
    }
    
    func saveNewPerson() {
        guard let uiImage = uiImage else { return }
        if newPersonName.isEmpty {
            print("Name cannot be empty - show alert for that")
            return
        }
        
        let imageSaver = ImageSaver()
        let fileName = newPersonName + String(Date().timeIntervalSince1970)
        print("New file name \(fileName)")
        
        imageSaver.successHandler = {
            print("Success")
            let newPerson = Person(name: newPersonName, imageURL: fileName)
            self.people.append(newPerson)
            self.saveData()
            self.uiImage = nil
            self.newPersonName = ""
        }
        
        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        
        imageSaver.writeToDisk(image: uiImage, name: fileName)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("People")
        
        do {
            let data = try Data(contentsOf: filename)
            let peopleArray = try JSONDecoder().decode([Person].self, from: data)
            people = peopleArray.sorted()
        } catch {
            print("Cannot decode data")
        }
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

struct GreenButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

extension View {
    func greenButton() -> some View {
        self.modifier(GreenButton())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
