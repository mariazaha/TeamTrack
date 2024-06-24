//
//  SignInView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/3/24.
//

import UIKit

class SignInView: UIViewController, UIScrollViewDelegate {
    
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
    
    private let imageSize = CGSize(width: 300.0, height: 300.0)
    lazy private var illustrationImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = IconService.illustration.signIn
        view.contentMode = .scaleAspectFit
        return view
    } ()
    
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
    
    lazy private var signInButtonSize = CGSize(
        width: view.frame.size.width - 2 * viewPadding,
        height: 50.0
    )
    lazy private var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints=false
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(ColorService.prominentButtonTitleColor(), for: .normal)
        button.backgroundColor = ColorService.tintColor()
        button.layer.cornerRadius = signInButtonSize.height / 2
        button.clipsToBounds = true
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.errorLabel.isHidden = true
            self?.interactor?.signInTapped()
        }), for: .touchUpInside)
        button.isEnabled = false
        button.backgroundColor = ColorService.placeholder()
        return button
    }()
    
    // Sign In Label & Button
    private let signUpStackSpacing: CGFloat = 6.0
    lazy private var signUpStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = signUpStackSpacing
        view.alignment = .center
        view.distribution = .fill
        return view
    }()
    
    lazy private var signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Don't have an account?"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = ColorService.title()
        return label
    }()
    
    lazy private var signUpButton: UIButton = {
       var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(ColorService.buttonTitleColor(), for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter?.routeToSignUp()
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
    
    var presenter: SignInPresenterProtocol?
    var interactor: SignInInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
}

extension SignInView {
    private func configureView() {
        view.backgroundColor = ColorService.systemBackground()
        configureScrollView()
        configureStackView()
        configureIllustration()
        configureTextFields()
        prepareErrorLabel()
        configureSignInButton()
        configureSignUpButton()
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
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        let width: CGFloat = view.frame.size.width - 2 * viewPadding
        
        NSLayoutConstraint.activate([
            emailTextField.widthAnchor.constraint(equalToConstant: width),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
        ])
    }
    
    private func configureSignInButton() {
        stackView.addArrangedSubview(signInButton)
        
        NSLayoutConstraint.activate([
            signInButton.widthAnchor.constraint(equalToConstant: signInButtonSize.width),
            signInButton.heightAnchor.constraint(equalToConstant: signInButtonSize.height),
        ])
    }
    
    private func configureSignUpButton() {
        stackView.addArrangedSubview(signUpStackView)
        signUpStackView.addArrangedSubview(signUpLabel)
        signUpStackView.addArrangedSubview(signUpButton)
    }
    
    private func prepareErrorLabel() {
        stackView.addArrangedSubview(errorLabel)
    }
    
}

extension SignInView : CustomTextFieldDelegate {
    func textFieldDidChange(type: CustomTextFieldType, text: String) {
        interactor?.textFieldDidChange(type: type, text: text)
    }
}

extension SignInView {
    func setSignInButton(enabled: Bool) {
        signInButton.isEnabled = enabled
        signInButton.backgroundColor = enabled ? ColorService.tintColor() : ColorService.placeholder()
    }
    
    func startActivityIndicator() {
        let customView = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
        self.navigationItem.rightBarButtonItem = customView
    }
    
    func endActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    func signInSuccessful() {
        errorLabel.isHidden = true
        presenter?.dismissToProfileView()
    }
    
    func signInFailed(with message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func completeSignUp() {
        presenter?.routeToCompleteSignUp()
    }
}
