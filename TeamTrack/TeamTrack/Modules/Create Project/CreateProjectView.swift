//
//  CreateProjectView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/30/24.
//

import UIKit

class CreateProjectView : UIViewController, UIScrollViewDelegate {
    
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
    
    private let imageSize = CGSize(width: 250.0, height: 250.0)
    lazy private var illustrationImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = IconService.illustration.createProject
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy private var nameTextField: CustomTextField = {
        let view = CustomTextField(.name)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.set(placeholder: "Project title")
        view.set(icon: IconService.outline.projectTitle)
        view.delegate = self
        return view
    }()
    
    lazy private var summaryTextField: CustomTextField = {
        let view = CustomTextField(.summary)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.set(placeholder: "Summary")
        view.set(icon: IconService.outline.projectDescription)
        view.delegate = self
        return view
    }()
    
    lazy private var assignTextField: CustomTextField = {
        let view = CustomTextField(.assign)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.set(placeholder: "Assign to...")
        view.set(icon: IconService.outline.profile)
        view.delegate = self
        return view
    }()
    
    lazy private var createButtonSize = CGSize(
        width: view.frame.size.width - 2 * viewPadding,
        height: 50.0
    )
    lazy private var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints=false
        button.setTitle("Create", for: .normal)
        button.setTitleColor(ColorService.prominentButtonTitleColor(), for: .normal)
        button.backgroundColor = ColorService.tintColor()
        button.layer.cornerRadius = createButtonSize.height / 2
        button.clipsToBounds = true
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.errorLabel.isHidden = true
            self?.interactor?.createProjectTapped()
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

    var presenter: CreateProjectPresenterProtocol?
    var interactor: CreateProjectInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
}

extension CreateProjectView {

    private func configureView() {
        view.backgroundColor = ColorService.systemBackground()
        configureScrollView()
        configureStackView()
        configureIllustration()
        configureTextFields()
        prepareErrorLabel()
        configureCreateButton()
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
        stackView.addArrangedSubview(summaryTextField)
        stackView.addArrangedSubview(assignTextField)
        
        let width: CGFloat = view.frame.size.width - 2 * viewPadding
        
        NSLayoutConstraint.activate([
            nameTextField.widthAnchor.constraint(equalToConstant: width),
            summaryTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            assignTextField.widthAnchor.constraint(equalTo: nameTextField.widthAnchor)
        ])
    }
    
    private func configureCreateButton() {
        stackView.addArrangedSubview(createButton)
        
        NSLayoutConstraint.activate([
            createButton.widthAnchor.constraint(equalToConstant: createButtonSize.width),
            createButton.heightAnchor.constraint(equalToConstant: createButtonSize.height),
        ])
    }
    
    private func prepareErrorLabel() {
        stackView.addArrangedSubview(errorLabel)
    }
    
}

extension CreateProjectView : CustomTextFieldDelegate {
    func textFieldDidChange(type: CustomTextFieldType, text: String) {
        interactor?.textFieldDidChange(type: type, text: text)
    }
    
    func setCreateButton(enabled: Bool) {
        createButton.isEnabled = enabled
        createButton.backgroundColor = enabled ? ColorService.tintColor() : ColorService.placeholder()
    }
    
    func startActivityIndicator() {
        let customView = UIBarButtonItem(customView: activityIndicator)
        activityIndicator.startAnimating()
        self.navigationItem.rightBarButtonItem = customView
    }
    
    func endActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    func creationFailed(with message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
}
