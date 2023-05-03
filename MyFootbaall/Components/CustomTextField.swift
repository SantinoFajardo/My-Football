//
//  CustomTextField.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import SwiftUI

struct CustomTextField: View {
    @Binding private var input: String
    @Binding private var error: String
    @State private var validator: () -> Void
    @State private var placeHolder: String
    
    init(input: Binding<String>, error: Binding<String>, validator: @escaping () -> Void, placeHolder: String) {
        _input = input
        _error = error
        self.validator = validator
        self.placeHolder = placeHolder
        
    }
    
    var body: some View {
        ZStack{
            if input.isEmpty{
                Text(self.placeHolder)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading)
                
            }
            TextField("",text: $input)
                .padding(.leading)
                .frame(height: 30)
                .border(error.isEmpty ? .blue : .red, width: 3)
                .cornerRadius(10)
                .font(.footnote)
                .onChange(of: input) { newValue in
                    validator()
                }
                .autocorrectionDisabled()
        }
    }
}

