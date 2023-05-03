//
//  RegisterView.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 25/04/2023.
//

import SwiftUI

struct ErrorsRegister {
    var email: String
    var password: String
    var name: String
}

struct RegisterView: View {
    @State private var emailInput: String = String()
    @State private var passwordInput: String = String()
    @State private var nameInput: String = String()
    @State private var errors: ErrorsRegister = ErrorsRegister(email: "", password: "",name:"")
    @ObservedObject var store: AppStore
    
    
    var body: some View {
        ZStack {
            Color(.white).ignoresSafeArea()
            VStack{
                Text("Welcome to My Football!🎉")
                    .foregroundColor(.black)
                    .bold()
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .multilineTextAlignment(.leading)
                
                // Forms
                VStack{
                    Text("Your email:")
                        .frame(maxWidth: .infinity,alignment:.leading)
                    CustomTextField(input: $emailInput,
                                    error: $errors.email,
                                    validator: {
                        validateRegister(email: emailInput, password: passwordInput, name: nameInput, errors: &errors)}, placeHolder: "example@example.com")
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    if !self.errors.email.isEmpty {
                        Text(self.errors.email)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment:.leading)
                    }
                    
                    Text("Your name:")
                        .frame(maxWidth: .infinity,alignment:.leading)
                    CustomTextField(input: $nameInput,
                                    error: $errors.name,
                                    validator: {
                        validateRegister(email: emailInput, password: passwordInput, name: nameInput, errors: &errors)}, placeHolder: "Your name")
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    if !self.errors.name.isEmpty {
                        Text(self.errors.name)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment:.leading)
                    }
                    
                    Text("Your password:")
                        .frame(maxWidth: .infinity,alignment:.leading)
                    CustomTextField(input: $passwordInput,
                                    error: $errors.password,
                                    validator: {
                        validateRegister(email: emailInput, password: passwordInput, name: nameInput, errors: &errors)}, placeHolder: "Your strong password")
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    if !self.errors.password.isEmpty {
                        Text(self.errors.password)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment:.leading)
                    }
                    
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
                .padding(.top,5)
                
                Button(action: {
                    store.reduce(action: .registerUser(name: nameInput, email: emailInput, password: passwordInput))
                }, label: {
                    Text("REGISTER")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .background(.green)
                        .cornerRadius(15)
                        .padding(.horizontal)
                })
                .padding(.top)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(store: AppStore(appState: AppState(), reducer: appReducer))
    }
}
