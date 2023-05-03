//
//  Models.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import Foundation

struct Player: Hashable,Identifiable {
    var id = UUID()
    var name: String
    var attak: Double
    var deffense: Double
    var Score: Double
    
    init(name: String, attak: Double, deffense: Double) {
        self.name = name
        self.attak = attak
        self.deffense = deffense
        self.Score = (attak + deffense) / 2
    }
}

struct User: Codable {
    let uid: String
    var name: String
    var email: String
}
