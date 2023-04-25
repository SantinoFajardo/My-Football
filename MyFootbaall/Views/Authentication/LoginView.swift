//
//  LoginView.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 24/04/2023.
//

import SwiftUI

struct ErrorsLogin {
    var email: String
    var password: String
}

struct LoginView: View {
    @State private var emailInput: String = String()
    @State private var passwordInput: String = String()
    @State private var errors: ErrorsLogin = ErrorsLogin(email: "", password: "")
    
    var body: some View {
        VStack{
            Text("Welcome again to My Football!🎉")
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
                    validateLogin(email: emailInput, password: passwordInput, errors: &errors)})
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                if !self.errors.email.isEmpty {
                    Text(self.errors.email)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .frame(maxWidth: .infinity, alignment:.leading)
                }
                
                Text("Your password:")
                    .frame(maxWidth: .infinity,alignment:.leading)
                CustomTextField(input: $passwordInput,
                                error: $errors.password,
                                validator: {
                    validateLogin(email: emailInput, password: passwordInput, errors: &errors)})
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
            
            Button(action: {}, label: {
                Text("LOGIN")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
