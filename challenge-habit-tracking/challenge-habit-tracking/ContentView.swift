//
//  ContentView.swift
//  challenge-habit-tracking
//
//  Created by Ania on 22/11/2020.
//

import SwiftUI

struct ActivityItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    var ammount: Int = 0
}

class Activities: ObservableObject {
    @Published var items = [ActivityItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(items) {
                UserDefaults.standard.setValue(data, forKey: "activities")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "activities") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ActivityItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    
    @ObservedObject var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    NavigationLink(destination: ActivityView(activity: item, activities: activities)) {
                        HStack {
                            VStack {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            VStack {
                                Text("\(item.ammount) times")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .onDelete(perform: removeActivity)
            }
            .navigationBarTitle("Activities")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                showingAddActivity = true
            }) {
                Image(systemName: "plus")
            })
        }.sheet(isPresented: $showingAddActivity, content: {
            AddActivityView(activities: self.activities)
        })
    }
    
    func removeActivity(at offset: IndexSet) {
        activities.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
