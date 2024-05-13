//
//  AuthenticationError.swift
//  TeamTrack
//
//  Created by Maria Zaha on 13.05.2024.
//

import Foundation

enum AuthenticationError : String, Error {
    case failedToUnwrapSignUpInformation = "Sign up information doesn't look right, try again later!"
    case failedToUnwrapSignInInformation = "Sign in information doesn't look right, try again later!"
    case other = "Something went wrong, try again later!"
    
    case failedToSignOut = "Could not sign out, try again later!"
    case failedToDeleteAccount = "Could not delete account, try again later!"
}
