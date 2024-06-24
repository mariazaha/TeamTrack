//
//  ProfileInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/2/24.
//

import UIKit

protocol ProfileInteractorProtocol {
    func computeNavigationButtons() -> ()
    func computeViewTitle() -> ()
    func computeProfileView() -> ()
    func computeBusinessHandle() -> ()
    func computeProjects() -> ()
}

class ProfileInteractor {
    weak var view: ProfileView?
    var appService: AppService?
    
    init(view: ProfileView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension ProfileInteractor : ProfileInteractorProtocol {
    
    func computeViewTitle() {
        if appService?.authService?.currentUser?.accountType == .owner {
            let viewTitle = appService?.authService?.currentUser?.businessName ?? "Home"
            view?.set(viewTitle: viewTitle)
        } else {
            let viewTitle = appService?.authService?.currentUser?.displayName ?? "Home"
            view?.set(viewTitle: viewTitle)
        }
    }
    
    func computeProfileView() {
        guard appService?.authService?.currentUser?.accountType != nil else {
            appService?.authService?.signOut(completion: { _ in })
            view?.configureSignedOutState()
            return
        }

        switch appService?.authService?.authenticationState {
        case .authenticated:
            view?.configureSignedInState()
        default:
            view?.configureSignedOutState()
        }
    }
    
    func computeBusinessHandle() {
        guard let businessHandle = appService?.authService?.currentUser?.businessHandle, !businessHandle.isEmpty else {
            return
        }
        view?.set(businessHandle: "@\(businessHandle)")
    }
    
    func computeNavigationButtons() {
        view?.removeNavBarButtons()
        switch appService?.authService?.authenticationState {
        case .authenticated:
            view?.addSettingsButton()
            if appService?.authService?.currentUser?.accountType == .owner {
                view?.addCreateProjectButton()
            }
        default:
            view?.removeNavBarButtons()
        }
    }
    
    func computeProjects() {
        switch appService?.authService?.currentUser?.accountType {
        case .employee:
            fetchEmployeeProjects()
        case .owner:
            fetchOwnerProjects()
        default:
            break
        }
    }
    
    private func fetchOwnerProjects() {
        guard let ownerId = appService?.authService?.currentUser?.uid else { return }
        appService?.projectService?.fetchProjects(ownerId: ownerId, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let projects):
                    self?.view?.set(projects: projects)
                case .failure(let error):
                    print(error.rawValue)
                    self?.view?.set(projects: [])
                }
                self?.view?.endActivityIndicator()
            }
        })
    }
    
    private func fetchEmployeeProjects() {
        view?.startActivityIndicator()
        guard let email = appService?.authService?.currentUser?.email else {
            view?.endActivityIndicator()
            return
        }
        appService?.projectService?.fetchProjects(employeeEmail: email, completion: { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let projects):
                    self?.view?.set(projects: projects)
                case .failure(let error):
                    print(error.rawValue)
                    self?.view?.set(projects: [])
                }
                self?.view?.endActivityIndicator()
            }
        })
    }
}
