//
//  ContentView.swift
//  challenge-friends
//
//  Created by Ania on 22/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users = [User]()
    
    static let serverAddress = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
    
    var body: some View {
        
        NavigationView{
            List {
                ForEach(self.users) { user in
                    NavigationLink(destination: UserView(user: user, users: users)) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(user.name)
                                .font(.headline)
                                .foregroundColor(user.isActive ?  Color.green : Color.gray)
                            Text(user.company)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Friends"))
        }
        .onAppear(perform: fetchData)
    }
    
    func fetchData() {
        let request = URLRequest(url: Self.serverAddress)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error \(error.localizedDescription)")
            } else {
                decodeData(data: data)
            }
        }.resume()
    }
    
    func decodeData(data: Data?) {
        guard let data = data else {
            return
        }
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([User].self, from: data) {
            self.users = decoded
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
