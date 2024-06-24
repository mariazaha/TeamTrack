//
//  ContentSelectionView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/17/24.
//

import UIKit

protocol ContentSelectionDelegate : AnyObject {
    func didSelect(type: ContentSelectionType) -> ()
}

class ContentSelectionView : UIView {
    
    private let cornerRadius: CGFloat = 16.0
    private let viewPadding: CGFloat = 16.0
    private var containerViewHeight: CGFloat = 90.0
    lazy private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor = ColorService.placeholder().cgColor
        view.layer.borderWidth = 1.0
        view.clipsToBounds = true
        return view
    }()
    
    lazy private var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = viewPadding
        return view
    }()
    
    private let iconCornerRadius: CGFloat = 8.0
    private let iconContainerPadding: CGFloat = 12.0
    lazy private var iconContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = iconCornerRadius
        view.layer.borderColor = ColorService.placeholder().cgColor
        view.layer.borderWidth = 1.0
        view.clipsToBounds = true
        return view
    }()
    
    private let iconSize = CGSize(
        width: 24.0,
        height: 24.0
    )
    lazy private var iconImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.tintColor = ColorService.placeholder()
        return view
    }()
    
    private let verticalStackSpacing: CGFloat = 3.0
    lazy private var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = verticalStackSpacing
        return view
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorService.title()
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        return label
    }()
    
    lazy private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorService.subtitle()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var isSelected: Bool = false {
        didSet {
            containerView.layer.borderColor = isSelected ? ColorService.tintColor().cgColor : ColorService.placeholder().cgColor
            containerView.layer.borderWidth = isSelected ? 2.5 : 1.0
            
            iconContainerView.layer.borderColor = isSelected ? ColorService.tintColor().cgColor : ColorService.placeholder().cgColor
            iconImageView.tintColor = isSelected ? ColorService.tintColor() : ColorService.placeholder()
        }
    }
    private var type: ContentSelectionType
    weak var delegate: ContentSelectionDelegate?
    
    init(_ type: ContentSelectionType) {
        self.type = type
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemeneted")
    }
    
    private func configureView() {
        configureTapGesture()
        
        addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        stackView.addArrangedSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleLabel)
        
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
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: iconContainerView.leftAnchor, constant: iconContainerPadding),
            iconImageView.topAnchor.constraint(equalTo: iconContainerView.topAnchor, constant: iconContainerPadding)
        ])
        
        updateView()
    }
    
    func set(isSelected: Bool) {
        self.isSelected = isSelected
    }
    
    private func updateView() {
        iconImageView.image = type.icon?.withRenderingMode(.alwaysTemplate)
        titleLabel.text = type.title
        subtitleLabel.text = type.subtitle
    }
    
    private func configureTapGesture() {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapView)))
    }
    
    @objc private func didTapView() {
        delegate?.didSelect(type: type)
    }
    
}
