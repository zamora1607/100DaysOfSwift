//
//  PersonView.swift
//  RememberPeople
//
//  Created by Ania on 28/12/2020.
//

import SwiftUI
import MapKit

struct PersonView: View {
    
    @State var person: Person
    @State private var annotation: MKPointAnnotation?
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    var body: some View {
        VStack {
            personImage
                .resizable()
                .scaledToFit()
            
            Text(person.name)
                .font(.title)
            MapView(centerCoordinate: $centerCoordinate, annotation: annotation)
        }
        .onAppear(perform: {
            makeAnnotation()
        })
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func makeAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: person.latitude ?? 0.0, longitude: person.longitude ?? 0.0)
        annotation.title = "Meeting place"
        self.annotation = annotation
        self.centerCoordinate = annotation.coordinate
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
