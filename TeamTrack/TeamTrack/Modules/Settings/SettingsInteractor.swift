//
//  SettingsInteractor.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/28/24.
//

import UIKit

protocol SettingsInteractorProtocol {
    func computeViewTitle() -> ()
    
    func computeSettingsItems() -> ()
    func didTap(setting: SettingItem) -> ()
}

class SettingsInteractor {
    weak var view : SettingsView?
    var appService : AppService?
    
    init(view: SettingsView, appService: AppService?) {
        self.view = view
        self.appService = appService
    }
}

extension SettingsInteractor : SettingsInteractorProtocol {
    func computeViewTitle() {
        view?.set(viewTitle: "Settings")
    }
    
    func computeSettingsItems() {
        var settings: [[SettingItem]] = []
        
        var updateSettings: [SettingItem] = []
        if appService?.authService?.currentUser?.accountType == .owner {
            updateSettings.append(
                SettingItem(
                    setting: .editProfile,
                    title: "Edit Business Information",
                    icon: IconService.outline.businessOwner
                )
            )
            updateSettings.append(
                SettingItem(
                    setting: .manageTeam,
                    title: "Manage Team",
                    icon: IconService.outline.team
                )
            )
            updateSettings.append(
                SettingItem(
                    setting: .updateInviteCode,
                    title: "Update Invite Code",
                    icon: IconService.outline.inviteCode
                )
            )
        } else {
            updateSettings.append(
                SettingItem(
                    setting: .editProfile,
                    title: "Edit Profile",
                    icon: IconService.outline.profile
                )
            )
        }
        if !updateSettings.isEmpty {
            settings.append(updateSettings)
        }
        
        var distructiveSettings: [SettingItem] = []
        distructiveSettings.append(
            SettingItem(
                setting: .deleteAccount,
                title: "Delete Account",
                icon: IconService.outline.delete
            )
        )
        distructiveSettings.append(
            SettingItem(
                setting: .signOut,
                title: "Sign Out",
                icon: IconService.outline.signOut
            )
        )
        settings.append(distructiveSettings)
        
        view?.set(settings: settings)
    }
    
    func didTap(setting: SettingItem) {
        switch setting.setting {
        case .deleteAccount:
            guard appService?.authService?.currentUser?.accountType != .owner else {
                let alertController = UIAlertController(
                    title: "Additional steps required",
                    message: "As a business owner, your account may be linked to other users on this platform and deleting it may distrupt their experience. If you are certain you wish to delete your account, please contact us!",
                    preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                view?.present(alertController, animated: true, completion: nil)
                return
            }
            
            let alertController = UIAlertController(
                title: "Delete Account",
                message: "Are you sure you want to delete your account?",
                preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { [weak self] _ in
                guard let uid = self?.appService?.authService?.currentUser?.uid else {
                    return
                }
                
                self?.appService?.userService?.deleteUser(uid: uid, completion: { result in
                    switch result {
                    case .success():
                        self?.appService?.authService?.deleteAccount(completion: { result in
                            switch result {
                            case .success( _):
                                DispatchQueue.main.async {
                                    self?.view?.navigationController?.popViewController(animated: true)
                                }
                            case .failure(let failure):
                                print(failure.rawValue)
                            }
                        })
                    case .failure(let error):
                        print(error.rawValue)
                    }
                })
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            view?.present(alertController, animated: true, completion: nil)
        case .signOut:
            let alertController = UIAlertController(
                title: "Sign Out",
                message: "Are you sure you want to sign out?",
                preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { [weak self] _ in
                self?.appService?.authService?.signOut(completion: { result in
                    switch result {
                    case .success( _):
                        DispatchQueue.main.async {
                            self?.view?.navigationController?.popViewController(animated: true)
                        }
                    case .failure(let failure):
                        print(failure.rawValue)
                    }
                })
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            view?.present(alertController, animated: true, completion: nil)
        case .updateInviteCode:
            break
        case .manageTeam:
            break
        case .editProfile:
            view?.editProfileTapped()
        }
    }
}
