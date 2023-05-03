//
//  ProfileView.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 29/04/2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var store: AppStore
    var body: some View {
        NavigationStack{
            Text(store.appState.User?.name ?? "")
            Button {
                store.reduce(action: .signoutUser)
            } label: {
                Text("Sign out")
            }

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(store: AppStore(appState: AppState(), reducer: appReducer))
    }
}
