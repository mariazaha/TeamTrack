//
//  AccountSettingsView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/30/24.
//

import UIKit

class AccountSettingsView : UIViewController, UIScrollViewDelegate {
    
    private let viewPadding: CGFloat = 16.0
    lazy private var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autoresizingMask = .flexibleHeight
        view.delegate = self
        view.bounces = true
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.clipsToBounds = true
        return view
    }()
    
    private let stackSpacing: CGFloat = 12.0
    lazy private var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = stackSpacing
        view.alignment = .center
        view.distribution = .fill
        return view
    }()
    
    lazy private var accountEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = ColorService.placeholder()
        label.isHidden = true
        return label
    }()
    
    private let imageSize = CGSize(width: 300.0, height: 300.0)
    lazy private var illustrationImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = IconService.illustration.completeSignUp
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var presenter: AccountSettingsPresenterProtocol?
    var interactor: AccountSettingsInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
}

extension AccountSettingsView {
    private func configureView() {
        view.backgroundColor = ColorService.systemBackground()
        configureScrollView()
        configureStackView()
        configureAccountEmail()
        configureIllustration()
    }
    
    private func configureNavigation() {
        interactor?.computeViewTitle()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = ColorService.tintColor()
    }
    
    func set(viewTitle: String) {
        title = viewTitle
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    private func configureStackView() {
        scrollView.addSubview(stackView)
        
        let viewWidth = view.frame.size.width
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -viewPadding),
            stackView.widthAnchor.constraint(equalToConstant: viewWidth)
        ])
    }
    
    private func configureIllustration() {
        stackView.addArrangedSubview(illustrationImageView)
        
        NSLayoutConstraint.activate([
            illustrationImageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            illustrationImageView.heightAnchor.constraint(equalToConstant: imageSize.height)
        ])
    }
    
}

extension AccountSettingsView {
    private func configureAccountEmail() {
        stackView.addArrangedSubview(accountEmailLabel)
        
        let viewWidth = view.frame.size.width - 2 * viewPadding
        NSLayoutConstraint.activate([
            accountEmailLabel.widthAnchor.constraint(equalToConstant: viewWidth)
        ])
        
        interactor?.computeAccountEmail()
    }
    
    func set(email: String) {
        accountEmailLabel.text = email
        accountEmailLabel.isHidden = false
    }
}



