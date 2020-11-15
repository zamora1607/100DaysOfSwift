//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Ania on 15/11/2020.
//

import SwiftUI
import CoreData

enum Predicate: String, CaseIterable {
    case beginsWith = "BEGINSWITH"
    case `in` = "IN"
    case equals = "=="
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> {fetchRequest.wrappedValue}
    
    let content: (T) -> Content
    
    init(filterKey: String, filterValue: String, predicate: Predicate, sortDescriptors: [NSSortDescriptor] , content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K %K %@", filterKey, predicate.rawValue, filterValue))
        self.content = content
    }
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
}
