//
//  ApplicationReducer.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import Foundation

func appReducer(action: AppAction,state: inout AppState){
    switch action {
    case .loadPlayer(let player):
        state.Players.append(player)
    }
}
