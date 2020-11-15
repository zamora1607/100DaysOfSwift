//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Ania on 14/11/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    
    let predEqual = NSPredicate(format: "universe == %@", "Star Wars")
    let predLess = NSPredicate(format: "name < %@", "F")
    let predIn = NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
    let predBegin = NSPredicate(format: "name BEGINSWITH %@", "E")
    let predCaseSensitive = NSPredicate(format: "name BEGINSWITH[c] %@", "e")
    let predNot = NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")
    
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "name < %@", "F")) var ships: FetchedResults<Ship>

    var body: some View {
        VStack {
            List(ships, id:\.self) { ship in
                Text(ship.name ?? "Uknown")
            }
            
            Button("Add Examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? self.moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
