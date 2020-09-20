//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Ania on 20/09/2020.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle scope")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded =  try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file)")
        }
        
        return loaded
    }
}

//Be very careful: There is a big difference between T and [T]. Remember, T is a placeholder for whatever type we ask for, so if we say “decode an array of astronauts,” then T becomes [Astronaut]. If we attempt to return [T] from decode() then we would actually be returning [[Astronaut]] – an array of arrays of astronauts!
