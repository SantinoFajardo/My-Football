//
//  EditSheet.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 02/05/2023.
//

import SwiftUI

struct EditSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var playerName: String = ""
    @State private var playerAttak: String = ""
    @State private var playerDeffense: String = ""
    @State private var name: String = String()
    @State private var attak: String = String()
    @State private var deffense: String = String()
    @State private var errors: ErrorPlayerForm = ErrorPlayerForm(name: "", attak: "", deffense: "")
    @ObservedObject var store: AppStore
    @State private var userUid: UUID
    
    
    init(playerName: String, playerAttak: String, playerDeffense: String, store: AppStore, userUid: UUID) {
        self._playerName = State(initialValue: playerName)
        self._playerAttak = State(initialValue: playerAttak)
        self._playerDeffense = State(initialValue: playerDeffense)
        self.store = store
        self._userUid = State(initialValue: userUid)
    }
    
    var body: some View {
        VStack{
            VStack {
                Button(action:{
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                }
            }
            .frame(maxWidth: .infinity,alignment:.trailing)
            Text("New name:")
            CustomTextField(input: $name,
                            error: $errors.name,
                            validator: {},
                            placeHolder: self.playerName)
            
            Text("New attak:")
            CustomTextField(input: $attak,
                            error: $errors.attak,
                            validator: {
                if  !(Double(attak) != nil) {
                    errors.attak = "This value might be a number like: 0.0"
                }else if Double(attak)! < 0 || Double(attak)! > 5 {
                    errors.attak = "This value should be between 0 and 5"
                }else{
                    errors.attak = ""
                }
            },
                            placeHolder: playerAttak)
            
            Text("New deffense:")
            CustomTextField(input: $deffense,
                            error: $errors.deffense,
                            validator: {
                if  !(Double(deffense) != nil) {
                    errors.deffense = "This value might be a number like: 0.0"
                }else if Double(deffense)! < 0 || Double(deffense)! > 5{
                    errors.deffense = "This value should be between 0 and 5"
                }else{
                    errors.deffense = ""
                }
            },
                            placeHolder: playerDeffense)
            
            Button(action: {
                if errors.attak.isEmpty && errors.deffense.isEmpty && errors.name.isEmpty {
                    store.reduce(action: .updatePlayer(id: self.userUid,
                                                       newName: self.name,
                                                       newAttak: Double(self.attak),
                                                       newDeffense: Double(self.deffense)))
                    self.name = String()
                    self.attak = String()
                    self.deffense = String()
                    self.errors = ErrorPlayerForm(name: "", attak: "", deffense: "")
                }
                
            }, label: {
                Text("UPDATE")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity,maxHeight:30)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(.top)
            })
        }
        .padding(.horizontal)
        .padding(.top,30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.top)
    }
}


