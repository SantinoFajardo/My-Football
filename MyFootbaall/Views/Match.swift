//
//  Match.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import SwiftUI

struct Match: View {
    @State private var players: [Player]
    @State private var match: ([String], [String])
    init(players: [Player]) {
        self.players = players
        self.match = createBalancedTeams(players: players)
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                List{
                    Section(header:Text("Team 1:")){
                        ForEach(match.0, id: \.self){ player in
                            Text(player)
                        }
                    }
                    
                    Section(header:Text("Team 2:")){
                        ForEach(match.1, id: \.self){ player in
                            Text(player)
                        }
                    }
                }
            }
            .navigationTitle("Match")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        self.match = createBalancedTeams(players: self.players)
                    }, label: {
                        Image(systemName: "repeat")
                    })
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct Match_Previews: PreviewProvider {
    static var previews: some View {
        let mockedMatch: [Player] = [Player(name: "Santino",
                                            attak: 2,
                                            deffense: 3),
                                     Player(name: "Tigre",
                                            attak: 4, deffense: 5),
                                     Player(name: "Santino",
                                            attak: 2,
                                            deffense: 3),
                                     Player(name: "Tigre",
                                            attak: 4, deffense: 5),
                                     Player(name: "Santino",
                                            attak: 2,
                                            deffense: 3),
                                     Player(name: "Tigre",
                                            attak: 4, deffense: 5),
                                     Player(name: "Santino",
                                            attak: 2,
                                            deffense: 3),
                                     Player(name: "Tigre",
                                            attak: 4, deffense: 5),
                                     Player(name: "Santino",
                                            attak: 2,
                                            deffense: 3),
                                     Player(name: "Tigre",
                                            attak: 4, deffense: 5)
        ]
        return Match(players: mockedMatch)
    }
}

