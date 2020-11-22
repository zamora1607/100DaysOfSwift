//
//  ActivityView.swift
//  challenge-habit-tracking
//
//  Created by Ania on 22/11/2020.
//

import SwiftUI

struct ActivityView: View {
    
    @ObservedObject var activities: Activities
    var activity: ActivityItem
    
    @State private var ammount: Int
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Activity of type: \(activity.type)")
                    .font(.subheadline)
                Stepper("Ammount \t \(ammount)", value: $ammount)
                    .padding()
                Spacer()
            }
        }.navigationBarTitle(Text(activity.name))
        .navigationBarItems(trailing: Button("Save") {
            let newActivity = ActivityItem(name: activity.name, type: activity.type, ammount: ammount)
            if let index = self.activities.items.firstIndex(where: { $0.id == activity.id }) {
                self.activities.items.remove(at: index)
                self.activities.items.append(newActivity)
            }
        })
    }
    
    init(activity: ActivityItem, activities: Activities) {
        self.activity = activity
        self.activities = activities
        _ammount = State(initialValue: activity.ammount)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(activity: ActivityItem(name: "name", type: "sport", ammount: 3), activities: Activities())
    }
}
