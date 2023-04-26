//
//  ValidateForm.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import Foundation

func validateEmail(_ email: String) -> Bool{
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}

func validateForm(name:String, attak: String, deffense: String, errors: inout ErrorPlayerForm) -> Void{
    // ------- name --------
    if name.isEmpty {
        errors.name = "Fill this field"
    }else{
        errors.name = ""
    }
    
    // -------- attak ---------
    if  !(Double(attak) != nil) {
        errors.attak = "This value might be a number like: 0.0"
    }else if attak.isEmpty{
        errors.attak = "Fill this field"
    }else if Double(attak)! < 0 || Double(attak)! > 5{
        errors.attak = "This value should be between 0 and 5"
    }else{
        errors.attak = ""
    }
    
    // ------- deffense --------
    if  !(Double(deffense) != nil){
        errors.deffense = "This value might be a number like: 0.0"
    }else if deffense.isEmpty{
        errors.deffense = "Fill this field"
    }else if Double(deffense)! < 0 || Double(deffense)! > 5 {
        errors.deffense = "This value should be between 0 and 5"
    }else{
        errors.deffense = ""
    }
}

func validateLogin(email: String, password: String, errors: inout ErrorsLogin){
    // ------ email --------
    let isValidEmail: Bool = validateEmail(email)
    if email.isEmpty {
        errors.email = "Fill this field"
    }else if !isValidEmail {
        errors.email = "Please put a valid email"
    }else {
        errors.email = ""
    }
    
    // ------- password --------
    if password.isEmpty {
        errors.password = "Please fill this field"
    }else {
        errors.password = ""
    }
    
}

func validateRegister(email:String, password: String, name: String, errors: inout ErrorsRegister){
    // ------ email --------
    let isValidEmail: Bool = validateEmail(email)
    if email.isEmpty {
        errors.email = "Fill this field"
    }else if !isValidEmail {
        errors.email = "Please put a valid email"
    }else {
        errors.email = ""
    }
    
    // ------- password --------
    if password.isEmpty {
        errors.password = "Please fill this field"
    }else {
        errors.password = ""
    }
    
    // ------- name --------
    if name.isEmpty {
        errors.name = "Please fill this field"
    }else {
        errors.name = ""
    }
}
