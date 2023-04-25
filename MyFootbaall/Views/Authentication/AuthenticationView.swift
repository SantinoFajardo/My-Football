//
//  LoginView.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 24/04/2023.
//

import SwiftUI

enum Authentication {
    case login
    case register
}

struct AuthenticationView: View {
    @State private var authenticationStatus: Authentication = .login
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing:60){
                    Button(action: {
                        self.authenticationStatus = .login
                    }, label: {
                        Text("LOG IN")
                            .font(.subheadline)
                            .foregroundColor(self.authenticationStatus != .login ? .green : .gray)
                    })
                    .disabled(self.authenticationStatus == .login)
                    
                    Button(action: {
                        self.authenticationStatus = .register
                    }, label: {
                        Text("SIGN IN")
                            .font(.subheadline)
                            .foregroundColor(self.authenticationStatus != .register ? .green : .gray)
                    })
                    .disabled(self.authenticationStatus == .register)
                    
                }
                
                ScrollView{
                    if self.authenticationStatus == .login {
                        LoginView()
                        
                    }else{
                        Text("Register")
                    }
                }
                .frame(maxWidth: .infinity ,maxHeight: .infinity, alignment: .top)
                .padding(.top)
                .navigationTitle("MY FOOTBALL")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
