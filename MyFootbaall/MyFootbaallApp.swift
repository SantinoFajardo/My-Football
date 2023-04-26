//
//  MyFootbaallApp.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 22/04/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct MyFootbaallApp: App {
    @ObservedObject var store: AppStore = AppStore(appState: AppState(), reducer: appReducer)
    // register app delegate for Firebase setup
     @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            if let _ = store.appState.User {
                ContentView(store: store)
            }else{
                AuthenticationView(store: store)
            }
        }
    }
}
