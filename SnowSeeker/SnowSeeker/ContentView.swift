//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ania on 08/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var favorites = Favorites()
    @State private var resorts: [Resort] = Resort.allResorts
    
    let prices = ["$$", "$$$"]
    let sizes = ["Small", "Average", "Large"]
    let countries = ["France", "Austria", "United States", "Italy", "Canada"]
    
    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favourite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    filterMenu
                    Button(action: sort) {
                        Image(systemName: "arrow.up.arrow.down.circle")
                    }
                }
            }
            WelcomeView()
        }
        .environmentObject(favorites)
        //.phoneOnlyStackNavigationView()
    }
    
    var filterMenu: some View {
        Menu("Filter") {
            Menu("Country") {
                ForEach(countries, id: \.self) { country in
                    Button(country) {
                        countryFilter(country)
                    }
                }
            }
            Menu("Size") {
                ForEach(sizes, id: \.self) { size in
                    Button(size) {
                        sizeFilter(size)
                    }
                }
            }
            Menu("Price") {
                ForEach(prices, id: \.self) { price in
                    Button(price) {
                        priceFilter(price)
                    }
                }
            }
        }
    }
    
    func countryFilter(_ country: String) {
        resorts = Resort.allResorts.filter { $0.country == country }
    }
    
    func priceFilter(_ price: String) {
        resorts = Resort.allResorts.filter { $0.price == price.count }
    }
    
    func sizeFilter(_ size: String) {
        var intSize = 0
        switch size {
        case "Small":
            intSize = 1
        case "Average":
            intSize = 2
        default:
            intSize = 3
        }
        resorts = Resort.allResorts.filter { $0.size == intSize }
    }
    
    func sort() {
        resorts = (Resort.allResorts.first == resorts.first) ? resorts.sorted() : Resort.allResorts
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it")
                .foregroundColor(.secondary)
        }
    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
