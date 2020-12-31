//
//  ContentView.swift
//  Shared
//
//  Created by Ania on 30/12/2020.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
//    let user = User()
    
    @State private var selectedTab = 0
    
    var body: some View {
//        VStack {
//            EditView()
//            DisplayView()
//        }.environmentObject(user)
        
        TabView(selection: $selectedTab) {
            Text("tab 1")
                .onTapGesture {
                    self.selectedTab = 1
                }
                .tabItem {
                    Image(systemName: "star")
                    Text("one")
                }
                .tag(0)
            Text("tab 2")
                .onTapGesture {
                    self.selectedTab = 2
                }
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("two")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
