//
//  SignUpView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/3/24.
//

import UIKit

class SignUpView: UIViewController, UIScrollViewDelegate {
    
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
        view.image = IconService.illustration.signUp
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // Sign Up Text Fields & Button
    lazy private var nameTextField: CustomTextField = {
        let view = CustomTextField(.name)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.set(placeholder: "Name")
        view.set(icon: IconService.outline.name)
        view.delegate = self
        return view
    }()

    lazy private var emailTextField: CustomTextField = {
        let view = CustomTextField(.email)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.set(placeholder: "Email")
        view.set(icon: IconService.outline.email)
        view.delegate = self
        return view
    }()

    lazy private var passwordTextField: CustomTextField = {
        let view = CustomTextField(.password)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.set(placeholder: "Password")
        view.set(isSecureTextEntry: true)
        view.set(icon: IconService.outline.password)
        view.delegate = self
        return view
    }()
    
    lazy private var confirmPasswordTextField: CustomTextField = {
        let view = CustomTextField(.confirmPassword)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.set(placeholder: "Confirm Password")
        view.set(isSecureTextEntry: true)
        view.set(icon: IconService.outline.password)
        view.delegate = self
        return view
    }()
    
    lazy private var signUpButtonSize = CGSize(
        width: view.frame.size.width - 2 * viewPadding,
        height: 50.0
    )
    lazy private var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints=false
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(ColorService.prominentButtonTitleColor(), for: .normal)
        button.backgroundColor = ColorService.tintColor()
        button.layer.cornerRadius = signUpButtonSize.height / 2
        button.clipsToBounds = true
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.errorLabel.isHidden = true
            self?.interactor?.signUpTapped()
        }), for: .touchUpInside)
        button.isEnabled = false
        button.backgroundColor = ColorService.placeholder()
        return button
    }()
    
    // Sign In Label & Button
    private let signInStackSpacing: CGFloat = 6.0
    lazy private var signInStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = signInStackSpacing
        view.alignment = .center
        view.distribution = .fill
        return view
    }()
    
    lazy private var signInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Already have an account?"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = ColorService.title()
        return label
    }()
    
    lazy private var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(ColorService.buttonTitleColor(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter?.routeToSignIn()
        }), for: .touchUpInside)
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
    
    var presenter: SignUpPresenterProtocol?
    var interactor: SignUpInteractorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
}

extension SignUpView {
    private func configureView() {
        view.backgroundColor = ColorService.systemBackground()
        configureIllustration()
        configureScrollView()
        configureStackView()
        configureTextFields()
        prepareErrorLabel()
        configureSignUpButton()
        configureSignInButton()
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
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        
        let width: CGFloat = view.frame.size.width - 2 * viewPadding
        
        NSLayoutConstraint.activate([
            nameTextField.widthAnchor.constraint(equalToConstant: width),
            emailTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            confirmPasswordTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor)
        ])
    }
    
    private func configureSignUpButton() {
        stackView.addArrangedSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            signUpButton.widthAnchor.constraint(equalToConstant: signUpButtonSize.width),
            signUpButton.heightAnchor.constraint(equalToConstant: signUpButtonSize.height),
        ])
    }
    
    private func configureSignInButton() {
        stackView.addArrangedSubview(signInStackView)
        signInStackView.addArrangedSubview(signInLabel)
        signInStackView.addArrangedSubview(signInButton)
    }
    
    private func prepareErrorLabel() {
        stackView.addArrangedSubview(errorLabel)
        
        let width: CGFloat = view.frame.size.width - 2 * viewPadding
        NSLayoutConstraint.activate([
            errorLabel.widthAnchor.constraint(equalToConstant: width),
        ])
    }

}

extension SignUpView : CustomTextFieldDelegate {
    func textFieldDidChange(type: CustomTextFieldType, text: String) {
        interactor?.textFieldDidChange(type: type, text: text)
    }
}

extension SignUpView {
    func setSignUpButton(enabled: Bool) {
        signUpButton.isEnabled = enabled
        signUpButton.backgroundColor = enabled ? ColorService.tintColor() : ColorService.placeholder()
    }
    
    func startActivityIndicator() {
        let customView = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
        self.navigationItem.rightBarButtonItem = customView
    }
    
    func endActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    func signUpSuccessful() {
        errorLabel.isHidden = true
        presenter?.routeToCompleteSignUp()
    }
    
    func signUpFailed(with message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
}
