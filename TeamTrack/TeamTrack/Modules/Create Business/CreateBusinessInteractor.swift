//
//  CreateBusinessInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/16/24.
//

import UIKit

protocol CreateBusinessInteractorProtocol {
    func computeViewTitle() -> ()
    func textFieldDidChange(type: CustomTextFieldType, text: String) -> ()
    func finishTapped() -> ()
}

class CreateBusinessInteractor {
    private weak var view : CreateBusinessView?
    private var appService : AppService?
    private var accountType: AccountType?
    
    private var businessToCreate: Business
    
    init(view: CreateBusinessView, appService: AppService?) {
        self.view = view
        self.appService = appService
        self.businessToCreate = Business()
    }
}

extension CreateBusinessInteractor : CreateBusinessInteractorProtocol {
    func computeViewTitle() {
        view?.set(viewTitle: "Create business")
    }
    
    func textFieldDidChange(type: CustomTextFieldType, text: String) {
        switch type {
        case .name:
            businessToCreate.name = text
        case .handle:
            businessToCreate.handle = text
        case .inviteCode:
            businessToCreate.inviteCode = text
        default:
            break
        }
        
        businessInformationDidChange()
    }
    
    private func businessInformationDidChange() {
        view?.setFinishButton(enabled: businessToCreate.isValid())
    }

    func finishTapped() {
        view?.view.endEditing(true)
        view?.setFinishButton(enabled: false)
        view?.startActivityIndicator()
        
        businessToCreate.ownerId = appService?.authService?.currentUser?.uid
        appService?.authService?.currentUser?.update(businessHandle: businessToCreate.handle)
        appService?.authService?.currentUser?.update(businessName: businessToCreate.name)
        
        appService?.businessService?.create(business: businessToCreate, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success( _):
                    self?.createUser()
                case .failure(let failure):
                    self?.view?.companyCreationFailed(with: failure.rawValue)
                }
            }
        })
    }
    
    private func createUser() {
        guard let user = appService?.authService?.currentUser else {
            view?.companyCreationFailed(with: UserError.failedToCreateUser.rawValue)
            return
        }
        
        appService?.userService?.create(user: user, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success( _):
                    self?.view?.companyCreationSuccessful()
                    self?.appService?.authService?.cacheCurrentUser()
                case .failure(let failure):
                    self?.view?.companyCreationFailed(with: failure.rawValue)
                }
            }
        })
        
    }
}
