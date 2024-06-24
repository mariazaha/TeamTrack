//
//  BusinessError.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/17/24.
//

import Foundation

enum BusinessError : String, Error {
    case missingHandle = "Handle is missing, try again later."
    case businessDoesNotExist = "Business does not exist, try a different handle."
    case handleAlreadyExists = "Handle is already is use, please try a new one."
    case failedToCreateBusiness = "Failed to create business, please try again later."
    case invalidInviteCode = "The invite code you entered in incorrect."
    case other = "Failed to check business uniqueness, try again later."
}
