//
//  Card.swift
//  Flashzilla
//
//  Created by Ania on 04/01/2021.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor i Doctor Who", answer: "Jodie Whittaker")
    }
}
