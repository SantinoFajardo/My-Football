//
//  controllers.swift
//  MyFootbaall
//
//  Created by Santino Fajardo on 29/04/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

func createNewUser(email: String, password: String,name:String, completionBlock: @escaping (Result<User, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
        // If the authentication throw error:
        if let error = error {
            print("Error creating a new user \(error.localizedDescription)")
            completionBlock(.failure(error))
            return
        }
        // If the authentication throw an user
        let db = Firestore.firestore()
        let email = authDataResult?.user.email ?? "No email"
        let newUser: [String: Any] = ["name": name, "email":email]
        db.collection("users").document((authDataResult?.user.uid)!).setData(newUser, merge: true){ error in
            if let error = error {
                print(error.localizedDescription)
                completionBlock(.failure(error))
                return
            }
        }
        print("New user created with info \(email) & \(name)")
        //          let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as NSString
        //          let filePath = cachePath.appendingPathComponent("myData.txt")
        //          let fileURL = URL(fileURLWithPath: filePath)
        //          FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)
        //          let dataToWrite = "Hello, World!".data(using: .utf8)
        //          try? dataToWrite?.write(to: fileURL)
        
        completionBlock(.success(.init(uid: (authDataResult?.user.uid)!, name: "", email: email)))
    }
}

func fetchUserData( completionBlock: @escaping (Result<User,Error>) -> Void) {
    let uid = Auth.auth().currentUser?.uid ?? ""
    let db = Firestore.firestore()
    let docRef = db.collection("users").document(uid)
    
    docRef.getDocument { Document, Error in
        if let error = Error {
            completionBlock(.failure(error))
        }
        if let document = Document, ((Document?.exists) != nil) {
            let data = document.data()
            let email = data?["email"] as? String ?? ""
            let name = data?["name"] as? String ?? ""
            completionBlock(.success(.init(uid:uid, name: name, email: email)))
        }
    }
}

func signinUser(email:String, password:String, completionBlock: @escaping (Result<User,Error>) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password){ AuthDataResult, Error in
        if let error = Error {
            completionBlock(.failure(error))
            print(error.localizedDescription)
            return
        }
        if let authResult = AuthDataResult {
            completionBlock(.success(.init(uid: (AuthDataResult?.user.uid)!, name: "", email: authResult.user.email!)))
        }
    }
}

func saveMatch(team1: [String],
               team2: [String],
               creator: String,
               place:String,
               date: String,
               completionBlock: @escaping (Result<String,Error>) -> Void){
    let db = Firestore.firestore()
    let newMatch : [String:Any] = ["creator": creator,
                                   "date" : date,
                                   "place": place,
                                   "team1" : team1,
                                   "team2": team2
    ]
    db.collection("matchs").addDocument(data: newMatch) { Error in
        if let error = Error {
            completionBlock(.failure(error))
            return
        }
        completionBlock(.success("We save the match successfully"))
        return
    }
}
