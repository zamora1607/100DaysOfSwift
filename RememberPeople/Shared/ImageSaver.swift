//
//  ImageSaver.swift
//  RememberPeople
//
//  Created by Ania on 28/12/2020.
//

import UIKit

class ImageSaver: NSObject {
    
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToDisk(image: UIImage, name: String) {
        let url = getDocumentsDirectory().appendingPathComponent(name)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            do {
                try jpegData.write(to: url, options: [.atomicWrite, .completeFileProtection])
                successHandler?()
            } catch {
                errorHandler?(error)
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
