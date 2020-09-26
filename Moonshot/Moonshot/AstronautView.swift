//
//  AstronautView.swift
//  Moonshot
//
//  Created by Ania on 26/09/2020.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let crewMissions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Spacer()
                    
                    Text("Missions: ")
                        .font(.title2)
                        .foregroundColor(.accentColor)
                    
                    Spacer()
                    
                    ForEach(self.crewMissions) { mission in
                        HStack {
                            Text(mission.displayName)
                                .fontWeight(.bold)
                            Text(formatDate(mission.launchDate))
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        var matches = [Mission]()
        
        for mission in missions {
            if let _ = mission.crew.first(where: {$0.name == astronaut.id}) {
                matches.append(mission)
            }
        }
        
        self.crewMissions = matches
    }
    
    func formatDate(_ date: Date?) -> String {
        guard let date = date else {
            return "Launch date: N/A"
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return "Launch date: \(formatter.string(from: date))"
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
