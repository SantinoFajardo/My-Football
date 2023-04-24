//
//  ValidateForm.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 23/04/2023.
//

import Foundation
func validateForm(name:String, attak: String, deffense: String, errors: inout Error) -> Void{
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
