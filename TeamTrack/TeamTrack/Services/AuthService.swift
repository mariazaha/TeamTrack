//
//  AuthService.swift
//  TeamTrack
//
//  Created by Maria Zaha on 02.05.2024.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    private(set) var currentUser: CurrentUser?
    private(set) var authenticationState: AuthenticationState?
    private var authenticationStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        currentUser = CurrentUser()
        registerAuthStateHandler()
    }
    
    private func registerAuthStateHandler() {
        guard authenticationStateHandler == nil else { return }
        authenticationStateHandler = Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
            self?.currentUser?.populate(from: user)
            self?.authenticationState = user == nil ? .unauthenticated : .authenticated
        })
    }
    
    func signUp(with data: SignUpInformation, completion: @escaping (Result<Void, AuthenticationError>) -> ()) {
        authenticationState = .authenticating
        
        guard let email = data.email, let password = data.password, let displayName = data.name else {
            completion(.failure(.failedToUnwrapSignUpInformation))
            return
        }
        
        Auth.auth().createUser(
            withEmail: email,
            password: password) { [weak self] authResult, error in
                guard error == nil else {
                    completion(.failure(.other))
                    return
                }
                
                self?.currentUser?.populate(from: authResult?.user)
                self?.currentUser?.update(displayName: displayName)
                self?.updateFirebaseUser(displayName: displayName)
                completion(.success(()))
            }
    }
    
    func signIn(with data: SignInInformation, completion: @escaping (Result<Void, AuthenticationError>) -> ()) {
        authenticationState = .authenticating
        
        guard let email = data.email, let password = data.password else {
            completion(.failure(.failedToUnwrapSignUpInformation))
            return
        }
        
        Auth.auth().signIn(
            withEmail: email,
            password: password) { [weak self] authResult, error in
                guard error == nil else {
                    completion(.failure(.other))
                    return
                }
                
                self?.currentUser?.populate(from: authResult?.user)
                completion(.success(()))
            }
    }
    
    func signOut(completion: @escaping (Result<Void, AuthenticationError>) -> ()) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(.failedToSignOut))
        }
    }
    
    func deleteAccount(completion: @escaping (Result<Void, AuthenticationError>) -> ()) {
        Auth.auth().currentUser?.delete(completion: { error in
            guard error == nil else {
                completion(.failure(.failedToDeleteAccount))
                return
            }

            completion(.success(()))
        })
    }
    
    private func updateFirebaseUser(displayName: String) {
        let updateRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        updateRequest?.displayName = displayName
        updateRequest?.commitChanges()
    }
    
}
