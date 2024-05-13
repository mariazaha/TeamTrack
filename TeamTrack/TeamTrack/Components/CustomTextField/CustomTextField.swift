//
//  CustomTextField.swift
//  TeamTrack
//
//  Created by Maria Zaha on 05.05.2024.
//

import UIKit

protocol CustomTextFieldDelegate : AnyObject {
    func textFieldDidChange(type: CustomTextFieldType, text: String) -> ()
}

class CustomTextField : UIView {
    
    private let viewPadding: CGFloat = 22.0
    private var containerViewHeight: CGFloat = 50.0
    lazy private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = containerViewHeight / 2
        view.layer.borderColor = ColorService.placeholder().cgColor
        view.layer.borderWidth = 1.0
        return view
    }()
    
    private let stackSpacing: CGFloat = 12.0
    lazy private var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = stackSpacing
        return view
    }()
    
    private let iconSize = CGSize(
        width: 20.0,
        height: 20.0
    )
    lazy private var iconImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.tintColor = ColorService.placeholder()
        return view
    }()
    
    lazy private var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.textColor = ColorService.title()
        textField.backgroundColor = .clear
        return textField
    }()
    
    private var type: CustomTextFieldType {
        didSet {
            switch type {
            case .email:
                textField.keyboardType = .emailAddress
            default:
                textField.keyboardType = .default
            }
        }
    }
    weak var delegate: CustomTextFieldDelegate?
    
    init(_ type: CustomTextFieldType) {
        self.type = type
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemeneted")
    }
    
    private func configureView() {
        addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(textField)
        
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: containerViewHeight),
            
            stackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: viewPadding),
            stackView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -viewPadding),
            stackView.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: iconSize.width),
            iconImageView.heightAnchor.constraint(equalToConstant: iconSize.height),
        ])
    }
    
    func set(icon: UIImage?) {
        iconImageView.image = icon?.withRenderingMode(.alwaysTemplate)
    }
    
    func set(placeholder: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: ColorService.placeholder()
            ]
        )
    }
    
    func set(isSecureTextEntry: Bool) {
        textField.isSecureTextEntry = isSecureTextEntry
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        delegate?.textFieldDidChange(type: type, text: text)
    }
    
}
