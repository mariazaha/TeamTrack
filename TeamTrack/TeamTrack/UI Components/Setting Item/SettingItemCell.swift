//
//  SettingItem.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/29/24.
//

import UIKit

class SettingItemCell : UICollectionViewCell {
    
    private let viewPadding: CGFloat = 16.0
    lazy private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = viewPadding
        view.clipsToBounds = true
        view.backgroundColor = ColorService.cellBackground()
        return view
    }()
    
    private let hStackSpacing: CGFloat = 12.0
    lazy private var hStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = hStackSpacing
        return view
    }()
    
    private let iconSize: CGSize = CGSize(width: 22.0, height: 22.0)
    lazy private var iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.tintColor = ColorService.title()
        return view
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorService.title()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let separatorHeight: CGFloat = 0.5
    lazy private var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorService.placeholder()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func configureView() {
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        containerView.addSubview(hStack)
        NSLayoutConstraint.activate([
            hStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            hStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            hStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: viewPadding)
        ])
        
        hStack.addArrangedSubview(iconView)
        hStack.addArrangedSubview(titleLabel)
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: iconSize.width),
            iconView.heightAnchor.constraint(equalToConstant: iconSize.height),
        ])
        
        containerView.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: viewPadding),
            separatorView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            separatorView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: separatorHeight)
        ])
    }
    
    func set(_ item: SettingItem) {
        iconView.image = item.icon?.withRenderingMode(.alwaysTemplate)
        titleLabel.text = item.title
    }
    
    func roundAllCorners() {
        containerView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
    }
    
    func roundTopCorners() {
        containerView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
    }
    
    func roundBottomCorners() {
        containerView.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
    }
    
    func doNotRoundCorners() {
        containerView.layer.maskedCorners = []
    }
    
    func setSeparator(hidden: Bool) {
        separatorView.isHidden = hidden
    }
    
    static var height: CGFloat = {
        return 50.0
    }()
    
}
