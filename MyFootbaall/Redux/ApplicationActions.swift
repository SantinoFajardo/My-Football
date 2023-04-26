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
    case registerUser(name: String, email: String, password: String)
}
