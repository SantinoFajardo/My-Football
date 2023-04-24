//
//  ContentView.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 22/04/2023.
//

import SwiftUI

struct Error{
    var name: String
    var attak: String
    var deffense: String
}


struct ContentView: View {
    @ObservedObject var store: AppStore = AppStore(appState: AppState(), reducer: appReducer)
    @State private var isSheet: Bool = false
    @State private var name: String = String()
    @State private var attak: String = String()
    @State private var deffense: String = String()
    @Environment(\.presentationMode) var presentationMode
    @State private var errors: Error = Error(name: "", attak: "", deffense: "")
    
    var body: some View {
        NavigationStack {
            List{
                // Each player name
                ForEach(store.appState.Players){ player in
                    VStack {
                        Text(player.name)
                            .foregroundColor(.black)
                            .id(player.id)
                    }
                    .padding(.vertical,5)
                }
            }
            .navigationTitle("Players")
            .toolbar{
                // Plus button
                ToolbarItem {
                    Button(action: {
                        if !self.isSheet {
                            self.isSheet = true
                        }
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                    
                }
                
                // Build button
                ToolbarItem {
                    Button(action: {
                        print("trigger")
                    }) {
                        NavigationLink(destination: Match(players: store.appState.Players)) {
                            Text("Build match")
                        }
                    }
                    
                }
            }
        }
        .toolbarBackground(.gray, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .preferredColorScheme(.light)
        .sheet(isPresented: $isSheet) {
            Sheet(name: $name, errors: $errors, attak: $attak, deffense: $deffense, store: store)
                .presentationDetents([.fraction(0.5)])
            .presentationDragIndicator(.visible)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
