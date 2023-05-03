//
//  Match.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import SwiftUI
import FirebaseAuth

struct Match: View {
    @State private var players: [Player]
    @State private var match: ([String], [String])
    @ObservedObject var store: AppStore
    @State private var sheet: Bool = false
    init(players: [Player],store: AppStore) {
        self._players = State(initialValue: players)
        self._match = State(initialValue: createBalancedTeams(players: players))
        self.store = store
    }
    @State private var place: String = String()
    @State private var selectedDate: Date = Date()
    @State private var alreadySaved: Bool = false
    @State private var showingAlert: Bool = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            VStack{
                List{
                    Section(header:Text("Team 1:")){
                        ForEach(match.0, id: \.self){ player in
                            Text(player)
                        }
                    }
                    
                    Section(header:Text("Team 2:")){
                        ForEach(match.1, id: \.self){ player in
                            Text(player)
                        }
                    }
                }
                Button(action: {
                    self.sheet = true
                }, label: {
                    Text("Save match")
                    
                })
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("We create the match successfully"),
                      message:Text("You can see this match in your matchs lists"),
                      dismissButton: .default(Text("Continue"))
                )
            }
            .navigationTitle("Match")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        self.match = createBalancedTeams(players: self.players)
                    }, label: {
                        Image(systemName: "repeat")
                    })
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: $sheet) {
                Form{
                    DatePicker("Date", selection: $selectedDate, in: Date()...)
                    TextField("Place of the match",text: $place)
                        .autocorrectionDisabled()
                }
                Button(action: {
                    store.reduce(action: .saveMatch(team1: match.0,
                                                    team2: match.1,
                                                    creator: Auth.auth().currentUser!.uid,
                                                    place: self.place,
                                                    date: dateFormatter.string(from: selectedDate)
                                                   ))
                    self.alreadySaved = true
                    self.showingAlert = true
                    self.sheet = false
                }, label: {Text("Save")})
                .disabled(self.alreadySaved)
                .presentationDetents([.fraction(0.25)])
                .presentationDragIndicator(.visible)
            }
            .onTapGesture {
                // Ocultar el teclado
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}

struct Match_Previews: PreviewProvider {
    static var previews: some View {
        let mockedMatch: [Player] = [Player(name: "Santino",
                                            attak: 2,
                                            deffense: 3),
                                     Player(name: "Tigre",
                                            attak: 4, deffense: 5),
                                     Player(name: "Santino",
                                            attak: 2,
                                            deffense: 3),
                                     Player(name: "Tigre",
                                            attak: 4, deffense: 5),
                                     Player(name: "Santino",
                                            attak: 2,
                                            deffense: 3),
                                     Player(name: "Tigre",
                                            attak: 4, deffense: 5),
                                     Player(name: "Santino",
                                            attak: 2,
                                            deffense: 3),
                                     Player(name: "Tigre",
                                            attak: 4, deffense: 5),
                                     Player(name: "Santino",
                                            attak: 2,
                                            deffense: 3),
                                     Player(name: "Tigre",
                                            attak: 4, deffense: 5)
        ]
        return Match(players: mockedMatch, store: AppStore(appState: AppState(), reducer: appReducer))
    }
}

