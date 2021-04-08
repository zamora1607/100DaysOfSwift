//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ania on 08/04/2021.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct ContentView: View {
    
    //@State private var selectedUser: User? = nil
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        //        NavigationView {
        //            NavigationLink(destination: Text("New secondary")) {
        //                Text("Hello, world!")
        //            }
        //            .navigationBarTitle("Primary")
        //
        //            Text("Secondary")
        //        }
        // 2
        //        Text("Hello, world")
        //            .onTapGesture {
        //                self.selectedUser = User()
        //            }
        //            .alert(item: $selectedUser) { user in
        //                Alert(title: Text(user.id))
        //            }
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack {
                    UserView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
