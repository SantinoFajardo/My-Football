//
//  ApplicationActions.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import Foundation

enum AppAction {
    case loadPlayer(player: Player)
    case deletePlayer(id: UUID)
    case updatePlayer(id: UUID, newName: String?, newAttak: Double?, newDeffense: Double?)
    case registerUser(name: String, email: String, password: String)
    case signoutUser
    case fetchUserData
    case signinUser(email: String, password: String)
    case saveMatch(team1:[String],team2: [String],creator: String, place: String,date:String)
}
