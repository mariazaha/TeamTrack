//
//  CreateEmployeeView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/19/24.
//

import UIKit

class CreateEmployeeView: UIViewController, UIScrollViewDelegate {
    
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

    private let imageSize = CGSize(width: 200.0, height: 200.0)
    lazy private var illustrationImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = IconService.illustration.createEmployee
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy private var handleTextField: CustomTextField = {
        let view = CustomTextField(.handle)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.set(placeholder: "Business Handle")
        view.set(icon: IconService.outline.handle)
        view.delegate = self
        return view
    }()
    
    lazy private var inviteCodeTextField: CustomTextField = {
        let view = CustomTextField(.inviteCode)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.set(placeholder: "Invite Code")
        view.set(icon: IconService.outline.inviteCode)
        view.delegate = self
        return view
    }()
    
    lazy private var joinButtonSize = CGSize(
        width: view.frame.size.width - 2 * viewPadding,
        height: 50.0
    )
    lazy private var joinButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints=false
        button.setTitle("Join", for: .normal)
        button.setTitleColor(ColorService.prominentButtonTitleColor(), for: .normal)
        button.backgroundColor = ColorService.tintColor()
        button.layer.cornerRadius = joinButtonSize.height / 2
        button.clipsToBounds = true
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.interactor?.joinTapped()
        }), for: .touchUpInside)
        button.isEnabled = false
        button.backgroundColor = ColorService.placeholder()
        return button
    }()
    
    lazy private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    lazy private var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = ColorService.error()
        label.textAlignment = .center
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()

    var presenter: CreateEmployeePresenterProtocol?
    var interactor: CreateEmployeeInteractorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
}

extension CreateEmployeeView {
    private func configureView() {
        view.backgroundColor = ColorService.systemBackground()
        configureScrollView()
        configureStackView()
        configureIllustration()
        configureTextFields()
        prepareErrorLabel()
        configureJoinButton()
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
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: viewPadding),
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
    
    private func configureTextFields() {
        stackView.addArrangedSubview(handleTextField)
        stackView.addArrangedSubview(inviteCodeTextField)
        
        let width: CGFloat = view.frame.size.width - 2 * viewPadding
        
        NSLayoutConstraint.activate([
            handleTextField.widthAnchor.constraint(equalToConstant: width),
            inviteCodeTextField.widthAnchor.constraint(equalTo: handleTextField.widthAnchor)
        ])
    }
    
    private func configureJoinButton() {
        stackView.addArrangedSubview(joinButton)
        
        NSLayoutConstraint.activate([
            joinButton.widthAnchor.constraint(equalToConstant: joinButtonSize.width),
            joinButton.heightAnchor.constraint(equalToConstant: joinButtonSize.height),
        ])
    }
    
    private func prepareErrorLabel() {
        stackView.addArrangedSubview(errorLabel)
        
        let width: CGFloat = view.frame.size.width - 2 * viewPadding
        NSLayoutConstraint.activate([
            errorLabel.widthAnchor.constraint(equalToConstant: width),
        ])
    }

}

extension CreateEmployeeView : CustomTextFieldDelegate {
    func textFieldDidChange(type: CustomTextFieldType, text: String) {
        interactor?.textFieldDidChange(type: type, text: text)
    }
}

extension CreateEmployeeView {
    func setJoinButton(enabled: Bool) {
        joinButton.isEnabled = enabled
        joinButton.backgroundColor = enabled ? ColorService.tintColor() : ColorService.placeholder()
    }

    func startActivityIndicator() {
        let customView = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
        self.navigationItem.rightBarButtonItem = customView
    }
    
    func endActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    func employeeCreationSuccessful() {
        endActivityIndicator()
        errorLabel.isHidden = true
        presenter?.routeToWelcome()
    }
    
    func employeeCreationFailed(with message: String) {
        endActivityIndicator()
        errorLabel.text = message
        errorLabel.isHidden = false
        setJoinButton(enabled: true)
    }
}
