//
//  AppUser.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/2/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

class AppUser {
    private(set) var uid: String?
    private(set) var displayName: String?
    private(set) var email: String?
    private(set) var accountType: AccountType?
    private(set) var businessHandle: String?
    private(set) var businessName: String?
    
    func populate(from user: User?) {
        self.uid = user?.uid
        self.displayName = user?.displayName
        self.email = user?.email
    }
    
    func update(displayName: String) {
        self.displayName = displayName
    }
    
    func update(accountType: AccountType) {
        self.accountType = accountType
    }
    
    func update(businessHandle: String?) {
        self.businessHandle = businessHandle
    }
    
    func update(businessName: String?) {
        self.businessName = businessName
    }
    
    func update(uid: String?) {
        self.uid = uid
    }
    
    func populate(from document: DocumentSnapshot) {
        
        if let accountTypeId = document["accountType"] as? Int {
            self.accountType = AccountType.accountType(for: accountTypeId)
        }
        
        if let displayName = document["name"] as? String {
            self.displayName = displayName
        }
        
        if let email = document["email"] as? String {
            self.email = email
        }
        
        if let businessHandle = document["businessHandle"] as? String {
            self.businessHandle = businessHandle
        }
        
        if let businessName = document["businessName"] as? String {
            self.businessName = businessName
        }
    }
    
    func merge(from appUser: AppUser) {
        self.accountType = appUser.accountType
        self.displayName = appUser.displayName
        self.businessHandle = appUser.businessHandle
        self.businessName = appUser.businessName
    }
    
    func documentData() -> [String: Any] {
        var dict = [String: Any]()
        dict["name"] = displayName
        dict["accountType"] = accountType?.rawValue
        dict["email"] = email
        dict["businessHandle"] = businessHandle
        dict["businessName"] = businessName
        return dict
    }
}
