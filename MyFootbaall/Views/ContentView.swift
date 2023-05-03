//
//  ContentView.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 22/04/2023.
//

import SwiftUI

struct ErrorPlayerForm {
    var name: String
    var attak: String
    var deffense: String
}

enum PlayerActions {
    case none
    case remove
    case edit
}


struct ContentView: View {
    @ObservedObject var store: AppStore
    @State private var isSheet: Bool = false
    @State private var name: String = String()
    @State private var attak: String = String()
    @State private var deffense: String = String()
    @State private var errors: ErrorPlayerForm = ErrorPlayerForm(name: "", attak: "", deffense: "")
    @State private var editUser: Player?
    @State private var showingOptions = false
    @State private var selection: PlayerActions = .none
    
    
    
    var body: some View {
        NavigationStack {
            List{
                // Each player name
                ForEach(store.appState.Players){ player in
                    VStack {
                        HStack{
                            Text(player.name)
                                .foregroundColor(.black)
                                .id(player.id)
                            
                            Spacer()
                            
                            Button(action: {
                                self.editUser = player
                                showingOptions = true
                            }, label: {
                                Image(systemName: "ellipsis.circle")
                            })
                            .confirmationDialog(self.editUser?.name ?? "", isPresented: $showingOptions, titleVisibility: .visible) {
                                Button(role: .destructive, action: {
                                    self.selection = .remove
                                    store.reduce(action: .deletePlayer(id: editUser?.id ?? UUID()))
                                    self.showingOptions = false
                                    self.selection = .none
                                }, label: {
                                    Text("Remove player")
                                })
                                
                                Button(action: {
                                    self.selection = .edit
                                    self.isSheet = true
                                }, label: {
                                    Text("Edit player")
                                })
                            }
                        }
                        
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
                            self.selection = .none
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
                        NavigationLink(destination: Match(players: store.appState.Players, store: store)) {
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
            if self.selection == .none {
                Sheet(name: $name, errors: $errors, attak: $attak, deffense: $deffense, store: store)
                    .presentationDetents([.fraction(0.5)])
                    .presentationDragIndicator(.visible)
            }else if self.selection == .edit {
                EditSheet(playerName: self.editUser!.name,
                          playerAttak: String(self.editUser!.attak),
                          playerDeffense: String(self.editUser!.deffense),
                          store: store, userUid: self.editUser!.id)
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: AppStore(appState: AppState(), reducer: appReducer))
    }
}

