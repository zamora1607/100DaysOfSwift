//
//  ContentView.swift
//  Instafilter
//
//  Created by Ania on 29/11/2020.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker()
        }
    }
}

//struct ContentView: View {
//
//    @State private var image: Image?
//
//    var body: some View {
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//        }
//        .onAppear(perform: loadImage)
//    }
//
//    func loadImage() {
//        guard let inputImage = UIImage(named: "example") else { return }
//        let beginImage = CIImage(image: inputImage)
//        let context = CIContext()
//
//        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
//        currentFilter.setValue(CIVector(x: inputImage.size.width / 2, y: inputImage.size.height / 2 ), forKey: kCIInputCenterKey)
//
//        guard let outputImage = currentFilter.outputImage else { return }
//
//        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
//            let uiImage = UIImage(cgImage: cgimg)
//
//            image = Image(uiImage: uiImage)
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
