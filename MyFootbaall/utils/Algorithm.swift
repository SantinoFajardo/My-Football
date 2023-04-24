//
//  Algorithm.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import Foundation
func createBalancedTeams(players: [Player]) -> ([String], [String]) {
    // create a list of players to work with this
    var listOfPlayers = players
    
    // mix the list of players to have differents results
    listOfPlayers.shuffle()
    
    // sorted the list of players
    let sortedPlayers = listOfPlayers.sorted { $0.Score > $1.Score }
    
    // create the instance of the each team
    var teamA = [String]()
    var teamB = [String]()
    
    // assign peer each time the respective player
    for (index, player) in sortedPlayers.enumerated() {
        if index % 2 == 0 {
            teamA.append(player.name)
        } else {
            teamB.append(player.name)
        }
    }
    
    return (teamA, teamB)
}
