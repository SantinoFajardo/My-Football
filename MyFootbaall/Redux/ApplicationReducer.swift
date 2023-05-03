//
//  ApplicationReducer.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine

func appReducer(action: AppAction,state: inout AppState) {
    switch action {
    case .loadPlayer(let player):
        state.Players.append(player)
    case .deletePlayer(id: let id):
        state.Players.removeAll{ $0.id == id }
    case .updatePlayer(id: let id, newName: let newName, newAttak: let newAttak, newDeffense: let newDeffense):
        if let playerIndex = state.Players.firstIndex(where: { $0.id == id }) {
            // Upgrade user features
            if let name = newName {
                state.Players[playerIndex].name = name
            }
            if let attak = newAttak {
                state.Players[playerIndex].attak = attak
            }
            if let deffense = newDeffense {
                state.Players[playerIndex].deffense = deffense
            }
            state.Players[playerIndex].Score = (state.Players[playerIndex].attak +  state.Players[playerIndex].deffense) / 2
        }
        
    case .registerUser(name: let name, email: let email, password: let password):
        state.loading = true
        createNewUser(email: email, password: password, name: name) { [state] result in
            switch result {
            case .success(let user):
                state.User = user
            case .failure(let error):
                print(error)
            }
        }
        
    case .signoutUser:
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("Error al cerrar la sesión del usuario: \(error.localizedDescription)")
        }
    case .fetchUserData:
        fetchUserData() { [state] result in
            switch result {
            case .success(let user):
                state.User = user
            case .failure(let error):
                print(error)
            }
        }
    case .signinUser(email: let email, password: let password):
        signinUser(email: email, password: password) { [state] result in
            switch result {
            case .success(let user):
                state.User = user
            case .failure(let error):
                print(error)
            }
        }
    case .saveMatch(team1: let team1, team2: let team2, creator: let creator, place: let place, date: let date):
        saveMatch(team1: team1, team2: team2, creator: creator, place: place, date: date) { result in
            switch result {
            case .success(let message):
                print(message)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

