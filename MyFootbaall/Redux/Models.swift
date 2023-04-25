//
//  Models.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import Foundation

struct Player: Hashable,Identifiable {
    var id = UUID()
    let name: String
    let attak: Double
    let deffense: Double
    let Score: Double
    
    init(name: String, attak: Double, deffense: Double) {
        self.name = name
        self.attak = attak
        self.deffense = deffense
        self.Score = (attak + deffense) / 2
    }
}

struct User: Codable {
    var name: String
    var email: String
}
