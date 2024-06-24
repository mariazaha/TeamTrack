//
//  ProjectError.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/30/24.
//

import Foundation

enum ProjectError : String, Error {
    case failedToCreateProject = "Failed to create project, please try again later."
    case failedToFetchProject = "Failed to fetch project, please try again later."
    case projectDoesNotExist = "Project does not exist."
    case failedToFetchOwnerProjects = "Failed to fetch owner projects, please try again later."
    case failedToFetchEmployeeProjects = "Failed to fetch employee projects, please try again later."
    case failedToFetchProjectDocuments = "No projects, try again later."
    case other = "Unknown error, try again later."
}
