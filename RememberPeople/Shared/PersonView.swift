//
//  PersonView.swift
//  RememberPeople
//
//  Created by Ania on 28/12/2020.
//

import SwiftUI

struct PersonView: View {
    
    @State var person: Person
    
    var body: some View {
        VStack {
            personImage
                .resizable()
                .scaledToFit()
            Text(person.name)
                .font(.title)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var personImage: Image {
        let fileName = getDocumentsDirectory().appendingPathComponent(person.imageURL)
        do {
            let data = try Data.init(contentsOf: fileName)
            let uiImage = UIImage(data: data)
            return Image(uiImage: uiImage!)
        } catch {
            return Image("person_example")
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: Person(name: "Ania", imageURL: ""))
    }
}
