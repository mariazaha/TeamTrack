//
//  CreateProjectInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/30/24.
//

import UIKit

protocol CreateProjectInteractorProtocol {
    func computeViewTitle() -> ()
    func textFieldDidChange(type: CustomTextFieldType, text: String) -> ()
    func createProjectTapped() -> ()
}

class CreateProjectInteractor {
    weak var view: CreateProjectView?
    var appService: AppService?
    
    private var project: Project
    
    init(view: CreateProjectView, appService: AppService?) {
        self.view = view
        self.appService = appService
        self.project = Project()
    }
}

extension CreateProjectInteractor : CreateProjectInteractorProtocol {
    
    func computeViewTitle() {
        view?.set(viewTitle: "New Project")
    }
    
    func textFieldDidChange(type: CustomTextFieldType, text: String) {
        switch type {
        case .name:
            project.name = text
        case .summary:
            project.summary = text
        case .assign:
            project.assigneeEmail = text.lowercased()
        default:
            break
        }
        
        projectInformationDidChange()
    }
    
    private func projectInformationDidChange() {
        view?.setCreateButton(enabled: project.isValid())
    }
    
    func createProjectTapped() {
        let localProject = project
        guard let email = project.assigneeEmail else { return }
        guard let ownerId = appService?.authService?.currentUser?.uid else { return }
        // Fetch user for email
        
        // Create project with user
        view?.view.endEditing(true)
        view?.setCreateButton(enabled: false)
        view?.startActivityIndicator()
        
        appService?.userService?.fetchUser(email: email, completion: { [weak self] result in
            switch result {
            case .success(let user):
                guard user.businessHandle == self?.appService?.authService?.currentUser?.businessHandle else {
                    self?.view?.endActivityIndicator()
                    self?.view?.creationFailed(with: UserError.userDoesNotExist.rawValue)
                    return
                }
                
                localProject.assignee = user.uid
                localProject.ownerId = ownerId
                self?.create(project: localProject)
            case .failure(let error):
                self?.view?.endActivityIndicator()
                self?.view?.creationFailed(with: error.rawValue)
            }
        })
    }
    
    private func create(project: Project) {
        appService?.projectService?.create(project: project, completion: { [weak self] result in
            switch result {
            case .success( _):
                self?.view?.navigationController?.popViewController(animated: true)
            case .failure(let error):
                self?.view?.endActivityIndicator()
                self?.view?.creationFailed(with: error.rawValue)
            }
        })
    }
}
