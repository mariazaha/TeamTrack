//
//  Project.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/30/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore

class Project {
    var id: String?
    var ownerId: String?
    var name: String?
    var summary: String?
    var status: Int? // 1 - Not Started; 2 - Active; 3 - Finished
    var assignee: String?
    var assigneeEmail: String?
    
    init() { }
    
    init(document: DocumentSnapshot) {
        populate(from: document)
    }
    
    func populate(from document: DocumentSnapshot) {
        
        if let id = document["id"] as? String {
            self.id = id
        }
        
        if let ownerId = document["ownerId"] as? String {
            self.ownerId = ownerId
        }
        
        if let name = document["name"] as? String {
            self.name = name
        }
        
        if let summary = document["summary"] as? String {
            self.summary = summary
        }
        
        if let status = document["status"] as? Int {
            self.status = status
        }
        
        if let assignee = document["assignee"] as? String {
            self.assignee = assignee
        }
        
        if let assigneeEmail = document["assigneeEmail"] as? String {
            self.assigneeEmail = assigneeEmail
        }
        
    }
    
    func documentData() -> [String: Any] {
        var dict = [String: Any]()
        dict["id"] = id
        dict["ownerId"] = ownerId
        dict["name"] = name
        dict["status"] = status
        dict["summary"] = summary
        dict["assignee"] = assignee
        dict["assigneeEmail"] = assigneeEmail
        return dict
    }
    
    func isValid() -> Bool {
        
        guard let name = name, !name.isEmpty else {
            return false
        }
        
        guard let summary = summary, !summary.isEmpty else {
            return false
        }
        
        guard let assigneeEmail = assigneeEmail, !assigneeEmail.isEmpty else {
            return false
        }
        
        return true
    }
}
