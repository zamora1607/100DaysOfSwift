//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by Ania on 09/04/2021.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort
    
    var body: some View {
        VStack {
            Text("Elevation: \(resort.elevation)")
            Text("Snow: \(resort.snowDepth)cm")
        }
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: Resort.example)
    }
}
