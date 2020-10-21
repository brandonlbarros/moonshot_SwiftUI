//
//  ContentView.swift
//  Moonshot
//
//  Created by Brandon Barros on 5/13/20.
//  Copyright © 2020 Brandon Barros. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showMembers = false
    
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
                        
                        if (self.showMembers) {
                            Text(self.getMemebers(mission: mission))
                                .font(.footnote)
                        } else {
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
            }
        .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button("Toggle Info") {
                self.showMembers.toggle()
            })
        }
    }
    
    
    func getMemebers(mission: Mission) -> String {
        var members = ""
        var one = true
        for member in mission.crew {
            for a in astronauts {
                if (member.name == a.id) {
                    if (one) {
                        one.toggle()
                    } else {
                        members += ", "
                    }
                    members += a.name
                }
            }
        }
        return members
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
