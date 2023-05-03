//
//  MyFootbaallApp.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 22/04/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct MyFootbaallApp: App {
    @StateObject var store: AppStore = AppStore(appState: AppState(), reducer: appReducer)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser != nil {
                NavTabView(store: store)
            } else {
                AuthenticationView(store: store)
            }
        }
    }
}
