//
//  BusinessService.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/17/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class BusinessService {
    
    private var database: Firestore
    private let businessRef = "BUSINESS"
    
    init() {
        database = Firestore.firestore()
    }
    
    func fetchBusiness(uid: String, completion: @escaping (Result<Business, BusinessError>) -> ()) {
        let businessRef = database.collection(businessRef)
        
        businessRef.document(uid).getDocument { document, error in
            
            guard error == nil else {
                completion(.failure(.other))
                return
            }
            
            guard let document = document, document.exists else {
                completion(.failure(.businessDoesNotExist))
                return
            }
            
            let business = Business()
            business.populate(from: document)
            completion(.success(business))
        }
    }
    
    func create(business: Business, completion: @escaping (Result<Void, BusinessError>) -> ()) {
        
        guard let handle = business.handle else {
            completion(.failure(.missingHandle))
            return
        }

        let businessRef = database.collection(businessRef)
        
        fetchBusiness(uid: handle) { result in
            switch result {
            case .success( _):
                completion(.failure(.handleAlreadyExists))
                return
            case .failure(let error):
                switch error {
                case .businessDoesNotExist:
                    let documentData = business.documentData()
                    businessRef.document(handle).setData(documentData) { error in
                        guard error == nil else {
                            completion(.failure(.failedToCreateBusiness))
                            return
                        }
                        completion(.success(()))
                    }
                default:
                    completion(.failure(.other))
                }
            }
        }
    }
    
    func check(inviteCode: String, for handle: String, completion: @escaping (Result<Business, BusinessError>) -> ()) {
        fetchBusiness(uid: handle) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let business):
                    guard inviteCode == business.inviteCode else {
                        completion(.failure(.invalidInviteCode))
                        return
                    }
                    completion(.success(business))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
    }
    
}
