//
//  ContentView.swift
//  Shared
//
//  Created by Ania on 28/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var people = [Person]()
    @State private var uiImage: UIImage?
    @State private var newPersonName: String = ""
    
    @State private var showImagePicker = false
    @State private var showAddPerson = false
    
    var body: some View {
        NavigationView {
            VStack {
                if showAddPerson {
                    VStack {
                        AddPerson(peopleArray: people, inputImage: uiImage!)
                    }
                    Spacer()
                } else {
                    VStack {
                        Spacer()
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
                }
            }.navigationBarTitle(Text("New people"))
        }
        .onAppear(perform: loadData)
        .sheet(isPresented: $showImagePicker, onDismiss: showAddPersonScreen) {
            ImagePicker(image: self.$uiImage)
        }
    }
    
    func showAddPersonScreen() {
        guard let _ = uiImage else { return }
        self.showAddPerson = true
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
