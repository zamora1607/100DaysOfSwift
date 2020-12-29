//
//  MapView.swift
//  RememberPeople
//
//  Created by Ania on 29/12/2020.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    var annotation: MKPointAnnotation?
    
    func makeUIView(context: Context) -> some MKMapView {
        let view = MKMapView()
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if uiView.isKind(of: MKMapView.self) {
            uiView.removeAnnotations(uiView.annotations)
            guard let annotation = self.annotation else { return }
            uiView.addAnnotation(annotation)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        let parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
    
}
