//
//  UserView.swift
//  challenge-friends
//
//  Created by Ania on 22/11/2020.
//

import SwiftUI

struct UserView: View {
    
    let user: User
    let users: [User]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Group {
                    Text("Age: \(user.age)")
                        .padding(.leading)
                    if user.isActive {
                        Text("Account: active")
                            .padding(.leading)
                    } else {
                        Text("Account: inactive")
                            .padding(.leading)
                    }
                    Text("Company: \(user.company)")
                        .padding(.leading)
                    Text("Email: \(user.email)")
                        .padding(.leading)
                    
                    Text("About")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .padding()
                    Text(user.about)
                        .padding(.leading)
                    
                    Text("Friends")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .padding()
                    List {
                        ForEach(user.friends) { friend in
                            NavigationLink(destination: UserView(user: self.users.first(where: {$0.id == friend.id})!, users: self.users)) {
                                Text(friend.name)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(user.name))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(id: "id-string", isActive: true, name: "Alejando Rodrigez", age: 26, company: "Coca-Cola", email: "alejandro@cocacola.com", address: "San Escobar", about: "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.\r\n", registered: "2014-07-05T04:25:04-01:00", tags: ["officia", "minim"], friends: [Friend(id: "fiend-id", name: "Tabitha Humphrey")]), users: [])
    }
}
