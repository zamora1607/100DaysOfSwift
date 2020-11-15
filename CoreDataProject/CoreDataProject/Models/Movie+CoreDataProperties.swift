//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Ania on 15/11/2020.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var director: String?
    @NSManaged public var title: String?
    @NSManaged public var year: Int16
    
    public var wrappedDirector: String {
        director ?? "Uknown director"
    }
    
    public var wrappedTitle: String {
        title ?? "Uknown title"
    }

}

extension Movie : Identifiable {

}
