//
//  AuthService.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/2/24.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class AuthService {
    
    private(set) var currentUser: AppUser?
    private(set) var authenticationState: AuthenticationState? {
        didSet {
            NotificationCenter.default.post(name: .authenticationStateChanged, object: nil)
        }
    }
    private var authenticationStateHandler: AuthStateDidChangeListenerHandle?
    private let currentUserCacheKey = "currentUserCacheKey"
    
    init() {
        currentUser = AppUser()
        
        
        if currentUser?.accountType == nil {
            resetCurrentUserCache()
            signOut(completion: { _ in })
            authenticationState = .unauthenticated
        }
        
        registerAuthStateHandler()
    }
    
    private func registerAuthStateHandler() {
        guard authenticationStateHandler == nil else { return }
        authenticationStateHandler = Auth.auth().addStateDidChangeListener({ [weak self] auth, user in
            self?.currentUser?.populate(from: user)
            self?.authenticationState = user == nil ? .unauthenticated : .authenticated
            if user != nil {
                self?.loadCurrentUserFromCache()
            }
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
                
                DispatchQueue.main.async {
                    self?.currentUser?.populate(from: authResult?.user)
                    completion(.success(()))
                }
            }
    }
    
    func signOut(completion: @escaping (Result<Void, AuthenticationError>) -> ()) {
        do {
            try Auth.auth().signOut()
            resetCurrentUserCache()
            currentUser = AppUser()
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
    
    func cacheCurrentUser() {
        var userData = [String: Any]()
        
        userData["accountType"] = currentUser?.accountType?.rawValue
        userData["businessHandle"] = currentUser?.businessHandle
        userData["businessName"] = currentUser?.businessName
        
        let defaults = UserDefaults.standard
        defaults.set(userData, forKey: currentUserCacheKey)
    }
    
    func loadCurrentUserFromCache() {
        let defaults = UserDefaults.standard
        guard let userData = defaults.object(forKey: currentUserCacheKey) as? [String: Any] else {
            return
        }
        
        if let businessHandle = userData["businessHandle"] as? String {
            currentUser?.update(businessHandle: businessHandle)
        }
        
        if let businessName = userData["businessName"] as? String {
            currentUser?.update(businessName: businessName)
        }
        
        if let accountTypeId = userData["accountType"] as? Int,
           let accountType = AccountType.accountType(for: accountTypeId) {
            currentUser?.update(accountType: accountType)
        }
    }
    
    func resetCurrentUserCache() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: currentUserCacheKey)
    }
    
}
