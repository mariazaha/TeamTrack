//
//  ProjectCell.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/30/24.
//

import UIKit

class ProjectCell : UICollectionViewCell {
    
    private let viewPadding: CGFloat = 16.0
    lazy private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = viewPadding
        view.clipsToBounds = true
        view.backgroundColor = ColorService.cellBackground()
        return view
    }()
    
    private let vStackSpacing: CGFloat = 8.0
    lazy private var vStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        view.spacing = vStackSpacing
        return view
    }()
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorService.title()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    lazy private var summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorService.placeholder()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private let assigneeStackSpacing: CGFloat = 6.0
    lazy private var assigneeStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = assigneeStackSpacing
        view.alignment = .center
        view.distribution = .fill
        return view
    }()
    
    lazy private var assigneeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorService.title()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    
    private let iconSize: CGSize = CGSize(width: 18.0, height: 18.0)
    lazy private var assigneeIconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.image = IconService.filled.user?.withRenderingMode(.alwaysTemplate)
        view.tintColor = ColorService.title()
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
        
        containerView.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: viewPadding),
            vStack.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: viewPadding),
            vStack.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -viewPadding),
        ])
        
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(summaryLabel)
        vStack.addArrangedSubview(assigneeStack)
        assigneeStack.addArrangedSubview(assigneeIconView)
        assigneeStack.addArrangedSubview(assigneeLabel)
        NSLayoutConstraint.activate([
            assigneeIconView.widthAnchor.constraint(equalToConstant: iconSize.width),
            assigneeIconView.heightAnchor.constraint(equalToConstant: iconSize.height),
        ])
    }
    
    func set(_ project: Project) {
        titleLabel.text = project.name
        summaryLabel.text = project.summary
        assigneeLabel.text = project.assigneeEmail
    }
    
    static var height: CGFloat = {
        return 120.0
    }()
    
}
