//
//  CompleteSignUpView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/16/24.
//

import UIKit

class CompleteSignUpView: UIViewController, UIScrollViewDelegate {
    
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
        view.image = IconService.illustration.completeSignUp
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy private var employeeOptionView: ContentSelectionView = {
        let view = ContentSelectionView(.employee)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    lazy private var businessOwnerOptionView: ContentSelectionView = {
        let view = ContentSelectionView(.owner)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    lazy private var disclaimerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This cannot be changed later"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = ColorService.placeholder()
        label.textAlignment = .center
        return label
    }()
    
    lazy private var continueButtonSize = CGSize(
        width: view.frame.size.width - 2 * viewPadding,
        height: 50.0
    )
    lazy private var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints=false
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(ColorService.prominentButtonTitleColor(), for: .normal)
        button.backgroundColor = ColorService.tintColor()
        button.layer.cornerRadius = continueButtonSize.height / 2
        button.clipsToBounds = true
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter?.routeToNextStep()
        }), for: .touchUpInside)
        button.isEnabled = false
        button.backgroundColor = ColorService.placeholder()
        return button
    }()

    var presenter: CompleteSignUpPresenterProtocol?
    var interactor: CompleteSignUpInteractorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
}

extension CompleteSignUpView {
    private func configureView() {
        view.backgroundColor = ColorService.systemBackground()
        configureScrollView()
        configureStackView()
        configureIllustration()
        configureOptions()
        configureDisclaimer()
        configureContinueButton()
    }
    
    private func configureNavigation() {
        interactor?.computeViewTitle()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = ColorService.tintColor()
        navigationItem.hidesBackButton = true
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
    
    private func configureOptions() {
        stackView.addArrangedSubview(employeeOptionView)
        stackView.addArrangedSubview(businessOwnerOptionView)
        
        let viewWidth = view.frame.size.width - 2 * viewPadding
        NSLayoutConstraint.activate([
            employeeOptionView.widthAnchor.constraint(equalToConstant: viewWidth),
            businessOwnerOptionView.widthAnchor.constraint(equalToConstant: viewWidth),
        ])
    }
    
    private func configureDisclaimer() {
        stackView.addArrangedSubview(disclaimerLabel)
        
        let viewWidth = view.frame.size.width - 2 * viewPadding
        NSLayoutConstraint.activate([
            disclaimerLabel.widthAnchor.constraint(equalToConstant: viewWidth),
        ])
    }
    
    private func configureContinueButton() {
        stackView.addArrangedSubview(continueButton)
        
        NSLayoutConstraint.activate([
            continueButton.widthAnchor.constraint(equalToConstant: continueButtonSize.width),
            continueButton.heightAnchor.constraint(equalToConstant: continueButtonSize.height),
        ])
    }
    
    func enableContinueButton() {
        continueButton.isEnabled = true
        continueButton.backgroundColor = ColorService.tintColor()
    }

}

extension CompleteSignUpView : ContentSelectionDelegate {
    func didSelect(type: ContentSelectionType) {
        switch type {
        case .employee:
            employeeOptionView.set(isSelected: true)
            businessOwnerOptionView.set(isSelected: false)
            interactor?.set(accountType: .employee)
        case .owner:
            employeeOptionView.set(isSelected: false)
            businessOwnerOptionView.set(isSelected: true)
            interactor?.set(accountType: .owner)
        default:
            return
        }
    }
}
