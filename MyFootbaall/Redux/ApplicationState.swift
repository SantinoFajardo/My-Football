//
//  ApplicationState.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import Foundation

class AppState: ObservableObject {
    var Players: [Player] = []
    @Published var User: User?
    var loading: Bool = false
    var isLogged: Bool = false
}
