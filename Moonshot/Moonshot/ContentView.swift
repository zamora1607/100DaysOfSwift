//
//  ContentView.swift
//  Moonshot
//
//  Created by Ania on 20/09/2020.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State var isDateVisible = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if isDateVisible {
                            Text(mission.formattedLaunchDate)
                        } else {
                            crewNames(crew: mission.crew)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Moonshot"))
            .navigationBarItems(trailing:
                                    Button(action: {
                                        isDateVisible.toggle()
                                    }) {
                                        Image(systemName: isDateVisible ? "person.circle" : "timer")
                                    }
            )
        }
    }
    
    func crewNames(crew: [Mission.CrewRole]) -> Text {
        var names = ""
        for item in crew {
            if let astronaut = astronauts.first(where: {$0.id == item.name}) {
                names.append(astronaut.name)
                if item.name != crew.last?.name {
                    names.append(", ")
                }
            }
        }
        return Text(names)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
