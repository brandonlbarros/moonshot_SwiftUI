//
//  AstronautView.swift
//  Moonshot
//
//  Created by Brandon Barros on 5/18/20.
//  Copyright © 2020 Brandon Barros. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var missionsFlown: String {
        var flown = "Mission(s) Flown:"
        var one = true
        for mission in missions {
            for member in mission.crew {
                if (member.name == astronaut.id) {
                    if (one) {
                        one.toggle()
                    } else {
                        flown += ","
                    }
                    flown += " \(mission.displayName)"
                }
            }
        }
        
        return flown
    }
    
    var body: some View {
        GeometryReader {geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.missionsFlown)
                        .font(.headline)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[7])
    }
}
