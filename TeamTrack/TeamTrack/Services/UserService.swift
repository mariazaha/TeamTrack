//
//  UserService.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/16/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class UserService {
    
    private var database: Firestore
    private let userRef = "USER"
    
    init() {
        database = Firestore.firestore()
    }
    
    func fetchUser(uid: String, completion: @escaping (Result<AppUser, UserError>) -> ()) {
        let userRef = database.collection(userRef)
        
        userRef.document(uid).getDocument { document, error in
            
            guard error == nil else {
                completion(.failure(.failedToFetchUser))
                return
            }
            
            guard let document = document, document.exists else {
                completion(.failure(.userAccountIncomplete))
                return
            }
            
            let appUser = AppUser()
            appUser.populate(from: document)
            completion(.success(appUser))
        }
    }
    
    func fetchUser(email: String, completion: @escaping (Result<AppUser, UserError>) -> ()) {
        let userRef = database.collection(userRef)
        let email = email.lowercased()
        
        userRef.whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            
            guard error == nil else {
                completion(.failure(.failedToFetchUser))
                return
            }
            
            guard let document = snapshot?.documents.first, document.exists else {
                completion(.failure(.userDoesNotExist))
                return
            }
            
            let appUser = AppUser()
            appUser.populate(from: document)
            appUser.update(uid: document.documentID)
            completion(.success(appUser))
        }
    }
    
    func create(user: AppUser, completion: @escaping (Result<Void, UserError>) -> ()) {
        guard let uid = user.uid else {
            completion(.failure(.missingId))
            return
        }
        
        let userRef = database.collection(userRef)
        let documentData = user.documentData()
        
        userRef.document(uid).setData(documentData) { error in
            guard error == nil else {
                completion(.failure(.failedToCreateUser))
                return
            }
            completion(.success(()))
        }
    }
    
    func deleteUser(uid: String, completion: @escaping (Result<Void, UserError>) -> ()) {
        let userRef = database.collection(userRef)
        
        userRef.document(uid).delete(completion: { error in
            guard error == nil else {
                print(error?.localizedDescription ?? "–")
                completion(.failure(.failedToDeleteUser))
                return
            }
            
            completion(.success(()))
        })
    }
    
}
