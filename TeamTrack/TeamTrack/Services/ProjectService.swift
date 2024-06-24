//
//  ProjectService.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/30/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ProjectService {
    
    private var database: Firestore
    private let projectsRef = "PROJECTS"
    
    init() {
        database = Firestore.firestore()
    }
    
    func create(project: Project, completion: @escaping (Result<Void, ProjectError>) -> ()) {
    
        let projectsCollection = database.collection(projectsRef)
        let documentId = projectsCollection.document().documentID
        let documentData = project.documentData()
        
        projectsCollection.document(documentId).setData(documentData) { error in
            guard error == nil else {
                completion(.failure(.failedToCreateProject))
                return
            }
            completion(.success(()))
        }
    }
    
    func fetchProject(uid: String, completion: @escaping (Result<Project, ProjectError>) -> ()) {
        let projectsCollection = database.collection(projectsRef)
        
        projectsCollection.document(uid).getDocument { document, error in
            
            guard error == nil else {
                completion(.failure(.failedToFetchProject))
                return
            }
            
            guard let document = document, document.exists else {
                completion(.failure(.projectDoesNotExist))
                return
            }
            
            let project = Project(document: document)
            completion(.success(project))
        }
    }
    
    func fetchProjects(ownerId: String, completion: @escaping (Result<[Project], ProjectError>) -> ()) {
        
        let projectsCollection = database.collection(projectsRef)
        
        projectsCollection.whereField("ownerId", isEqualTo: ownerId).getDocuments { snapshot, error in
            guard error == nil else {
                completion(.failure(.failedToFetchOwnerProjects))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.failure(.failedToFetchProjectDocuments))
                return
            }
            
            var projects: [Project] = []
            
            for document in documents {
                projects.append(Project(document: document))
            }
            
            completion(.success(projects))
        }
    }
    
    func fetchProjects(employeeEmail: String, completion: @escaping (Result<[Project], ProjectError>) -> ()) {
        
        let projectsCollection = database.collection(projectsRef)
        
        projectsCollection.whereField("assigneeEmail", isEqualTo: employeeEmail).getDocuments { snapshot, error in
            guard error == nil else {
                completion(.failure(.failedToFetchEmployeeProjects))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.failure(.failedToFetchProjectDocuments))
                return
            }
            
            var projects: [Project] = []
            
            for document in documents {
                projects.append(Project(document: document))
            }
            
            completion(.success(projects))
        }
    }
    
}
