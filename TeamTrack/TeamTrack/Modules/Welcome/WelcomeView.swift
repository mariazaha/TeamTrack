//
//  WelcomeView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/17/24.
//

import UIKit

class WelcomeView: UIViewController, UIScrollViewDelegate {
    
    private let viewPadding: CGFloat = 16.0
    private let imageSize = CGSize(width: 300.0, height: 300.0)
    lazy private var illustrationImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = IconService.illustration.welcome
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let stackSpacing: CGFloat = 8.0
    lazy private var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = stackSpacing
        view.distribution = .fill
        return view
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your account is ready to go!"
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textColor = ColorService.title()
        return label
    }()
    
    lazy private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = ColorService.placeholder()
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    lazy private var getStartedButtonSize = CGSize(
        width: view.frame.size.width - 2 * viewPadding,
        height: 50.0
    )
    lazy private var getStartedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints=false
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(ColorService.prominentButtonTitleColor(), for: .normal)
        button.backgroundColor = ColorService.tintColor()
        button.layer.cornerRadius = getStartedButtonSize.height / 2
        button.clipsToBounds = true
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter?.getStartedTapped()
        }), for: .touchUpInside)
        button.backgroundColor = ColorService.tintColor()
        return button
    }()

    var presenter: WelcomePresenterProtocol?
    var interactor: WelcomeInteractorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
}

extension WelcomeView {

    private func configureView() {
        view.backgroundColor = ColorService.systemBackground()
        configureIllustration()
        configureGetStartedButton()
        configureStackView()
        configureLabels()
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = ColorService.tintColor()
        navigationItem.hidesBackButton = true
    }
    
    private func configureIllustration() {
        view.addSubview(illustrationImageView)
        
        NSLayoutConstraint.activate([
            illustrationImageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            illustrationImageView.heightAnchor.constraint(equalToConstant: imageSize.height),
            illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            illustrationImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func configureStackView() {
        view.addSubview(verticalStackView)
        
        let width = view.frame.size.width - 2 * viewPadding
        NSLayoutConstraint.activate([
            verticalStackView.widthAnchor.constraint(equalToConstant: width),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: getStartedButton.topAnchor, constant: -viewPadding)
        ])
    }
    
    private func configureLabels() {
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)
        
        interactor?.computeSubtitle()
    }
    
    func set(subtitle: String) {
        subtitleLabel.text = subtitle
        subtitleLabel.isHidden = false
    }
    
    private func configureGetStartedButton() {
        view.addSubview(getStartedButton)
        
        NSLayoutConstraint.activate([
            getStartedButton.widthAnchor.constraint(equalToConstant: getStartedButtonSize.width),
            getStartedButton.heightAnchor.constraint(equalToConstant: getStartedButtonSize.height),
            getStartedButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -viewPadding),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

}
