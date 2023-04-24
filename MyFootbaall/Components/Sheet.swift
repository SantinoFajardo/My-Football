//
//  Sheet.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 24/04/2023.
//

import SwiftUI

struct Sheet: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding private var name: String
    @Binding private var errors: Error
    @Binding private var attak: String
    @Binding private var deffense: String
    @ObservedObject var store: AppStore

    init (name: Binding<String>, errors: Binding<Error>, attak: Binding<String>, deffense: Binding<String>, store: AppStore) {
        _name = name
        _errors = errors
        _attak = attak
        _deffense = deffense
        self.store = store
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
            VStack{
                Text("Name:")
                CustomTextField(input: $name,
                                error: $errors.name,
                                validator: {validateForm(name: self.name,
                                                         attak: self.attak,
                                                         deffense: self.deffense,
                                                         errors: &self.errors)})
                
                if !self.errors.name.isEmpty {
                    VStack{
                        Text(self.errors.name)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity,alignment:.leading)
                }
                
                Text("Attak:")
                CustomTextField(input: $attak,
                                error: $errors.attak,
                                validator: {validateForm(name: self.name,
                                                         attak: self.attak,
                                                         deffense: self.deffense,
                                                         errors: &self.errors)})
                
                if !self.errors.attak.isEmpty {
                    VStack{
                        Text(self.errors.attak)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity,alignment:.leading)
                }
                
                Text("Deffense:")
                CustomTextField(input: $deffense,
                                error: $errors.deffense,
                                validator: {
                    validateForm(name: self.name,
                                 attak: self.attak,
                                 deffense: self.deffense,
                                 errors: &self.errors)})
                
                if !self.errors.deffense.isEmpty {
                    VStack{
                        Text(self.errors.deffense)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                    .frame(maxWidth: .infinity,alignment:.leading)
                }
            }
            
            
            Button(action: {
                validateForm(name: self.name, attak: self.attak, deffense: self.deffense, errors: &self.errors)
                if errors.attak.isEmpty && errors.deffense.isEmpty && errors.name.isEmpty {
                    store.reduce(action: .loadPlayer(player: Player(name: name, attak: Double(attak)!, deffense: Double(deffense)!)))
                    self.name = String()
                    self.attak = String()
                    self.deffense = String()
                    self.errors = Error(name: "", attak: "", deffense: "")
                }
                
            }, label: {
                Text("ADD")
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

