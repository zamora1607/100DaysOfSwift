//
//  User.swift
//  challenge-friends
//
//  Created by Ania on 22/11/2020.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String //Date
    let tags: [String]
    let friends: [Friend]
}
