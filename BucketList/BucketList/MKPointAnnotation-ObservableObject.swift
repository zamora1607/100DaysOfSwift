//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Ania on 20/12/2020.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Uknown value"
        }
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Uknown value"
        }
        set {
            self.subtitle = newValue
        }
    }
}
