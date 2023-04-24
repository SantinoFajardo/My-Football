//
//  ApplicationStore.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import Foundation

class AppStore: ObservableObject {
    @Published private(set) var appState: AppState
    private let reducer: (AppAction, inout AppState) -> Void
    
    init(appState: AppState, reducer: @escaping (AppAction, inout  AppState) -> Void) {
        self.appState = appState
        self.reducer = reducer
    }
    
    func reduce(action: AppAction){
        appReducer(action: action, state: &appState)
    }
}
