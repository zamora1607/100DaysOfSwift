//
//  FileManagerExtension.swift
//  BucketList
//
//  Created by Ania on 15/12/2020.
//

import Foundation

extension FileManager {
    func decode<T: Codable>(_ fileName: String) -> T {
        let documentDirectory = self.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentDirectory.appendingPathComponent(fileName)
        
        guard let content = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(fileName) from document directory")
        }
        
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: content) else {
            fatalError("Failed to decode \(fileName)")
        }
        return loaded
    }
    
}
