//
//  UserError.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/16/24.
//

import Foundation

enum UserError : String, Error {
    case userAccountIncomplete = "Please complete the sign up process."
    case missingId = "User id is missing, try again later."
    case failedToCreateUser = "Failed to create user, try again later!"
    case failedToFetchUser = "Failed to fetch user, try again later!"
    case failedToDeleteUser = "Failed to delete user, try again later!"
    case userDoesNotExist = "This email does not belong to anyone from your company, try again!"
}
