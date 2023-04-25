//
//  ApplicationReducer.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import Foundation
import Firebase
import FirebaseFirestore

func appReducer(action: AppAction,state: inout AppState){
    switch action {
    case .loadPlayer(let player):
        state.Players.append(player)
    case .deletePlayer(id: let id):
        state.Players.removeAll{ $0.id == id }
    case .registerUser(name: let name, email: let email, password: let password, completion: let completion):
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let _ = authResult?.user, error == nil else {
                completion(false, error)
                return
            }
            let db = Firestore.firestore()
            let newUser: [String: Any] = ["name": name, "email":email]
            db.collection("users").addDocument(data: newUser) { error in
                if let error = error {
                    completion(false, error)
                } else {
                    completion(true, nil)
                }
            }
        }
    }
    
}

