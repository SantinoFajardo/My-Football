//
//  NavTabView.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 29/04/2023.
//

import SwiftUI
import FirebaseAuth

struct NavTabView: View {
    @ObservedObject var store: AppStore
    
    var body: some View {
        TabView{
            ContentView(store:store)
                .tabItem {
                    HStack{
                        Image(systemName: "figure.soccer")
                        Text("Match creator")
                    }
                }
            
            ProfileView(store: store)
                .tabItem {
                    HStack{
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                }
        }.onAppear{
            store.reduce(action: .fetchUserData)
        }
    }
}

struct NavTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavTabView(store: AppStore(appState: AppState(), reducer: appReducer))
    }
}
