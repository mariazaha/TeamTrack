//
//  CreateEmployeeInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/19/24.
//

import UIKit

protocol CreateEmployeeInteractorProtocol {
    func computeViewTitle() -> ()
    func textFieldDidChange(type: CustomTextFieldType, text: String) -> ()
    func joinTapped() -> ()
}

class CreateEmployeeInteractor {
    private weak var view : CreateEmployeeView?
    private var appService : AppService?
    private var accountType: AccountType?
    
    private var employeeInformation: CreateEmployeeInformation
    
    init(view: CreateEmployeeView, appService: AppService?) {
        self.view = view
        self.appService = appService
        self.employeeInformation = CreateEmployeeInformation()
    }
}

extension CreateEmployeeInteractor : CreateEmployeeInteractorProtocol {
    func computeViewTitle() {
        view?.set(viewTitle: "Join your team")
    }
    
    func textFieldDidChange(type: CustomTextFieldType, text: String) {
        switch type {
        case .handle:
            employeeInformation.handle = text
        case .inviteCode:
            employeeInformation.inviteCode = text
        default:
            break
        }
        
        employeeInformationDidChange()
    }
    
    private func employeeInformationDidChange() {
        view?.setJoinButton(enabled: employeeInformation.isValid())
    }

    func joinTapped() {
        view?.view.endEditing(true)
        view?.setJoinButton(enabled: false)
        view?.startActivityIndicator()
        
        guard let inviteCode = employeeInformation.inviteCode, let handle = employeeInformation.handle else {
            view?.employeeCreationFailed(with: BusinessError.other.rawValue)
            return
        }

        appService?.businessService?.check(inviteCode: inviteCode, for: handle, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let business):
                    self?.createUser(with: business)
                case .failure(let failure):
                    self?.view?.employeeCreationFailed(with: failure.rawValue)
                }
            }
        })
    }

    private func createUser(with team: Business) {
        appService?.authService?.currentUser?.update(businessHandle: team.handle)
        appService?.authService?.currentUser?.update(businessName: team.name)
        guard let user = appService?.authService?.currentUser else {
            view?.employeeCreationFailed(with: UserError.failedToCreateUser.rawValue)
            return
        }
   
        appService?.userService?.create(user: user, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success( _):
                    self?.view?.employeeCreationSuccessful()
                    self?.appService?.authService?.cacheCurrentUser()
                case .failure(let failure):
                    self?.view?.employeeCreationFailed(with: failure.rawValue)
                }
            }
        })
       
    }
}
