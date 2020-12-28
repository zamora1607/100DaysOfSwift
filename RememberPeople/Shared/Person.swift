//
//  Person.swift
//  RememberPeople
//
//  Created by Ania on 28/12/2020.
//

import Foundation
import SwiftUI

struct Person: Codable, Comparable {
    var uuid: UUID = UUID()
    var name: String
    var imageURL: String
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
}
