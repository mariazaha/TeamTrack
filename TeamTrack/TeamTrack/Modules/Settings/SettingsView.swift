//
//  SettingsView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/28/24.
//

import UIKit

class SettingsView: UIViewController, UIScrollViewDelegate {
    
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
        view.image = IconService.illustration.settings
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy private var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        return layout
    }()
    
    private let settingItemReuseIdentifier = "settingItemCell"
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    lazy private var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(SettingItemCell.self, forCellWithReuseIdentifier: settingItemReuseIdentifier)
        view.isScrollEnabled = false
        return view
    }()
    
    var presenter: SettingsPresenterProtocol?
    var interactor: SettingsInteractorProtocol?
    private var settings: [[SettingItem]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
    }
}

extension SettingsView {
    private func configureView() {
        view.backgroundColor = ColorService.systemBackground()
        configureScrollView()
        configureStackView()
        configureIllustration()
        configureCollectionView()
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
    
    private func configureCollectionView() {
        stackView.addArrangedSubview(collectionView)
        let viewWidth = view.frame.size.width - 2 * viewPadding
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalToConstant: viewWidth)
        ])
        
        interactor?.computeSettingsItems()
    }
    
    func set(settings: [[SettingItem]]) {
        self.settings = settings
        
        var settingsCount = 0
        for setting in settings {
            settingsCount += setting.count
        }
        
        let viewHeight = CGFloat(settingsCount) * SettingItemCell.height + CGFloat(settings.count) * viewPadding
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: viewHeight)
        collectionViewHeightConstraint?.isActive = true
    }

}

extension SettingsView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.frame.size.width - 2 * viewPadding
        let cellHeight = SettingItemCell.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: settingItemReuseIdentifier, for: indexPath) as? SettingItemCell else {
            return UICollectionViewCell()
        }
        
        let section = indexPath.section
        let index = indexPath.item
        let setting = settings[section][index]
        cell.set(setting)
    
        if settings[section].count == 1 {
            cell.roundAllCorners()
            cell.setSeparator(hidden: true)
        } else if index == 0 {
            cell.roundTopCorners()
            cell.setSeparator(hidden: false)
        } else if index == settings[section].count - 1 {
            cell.roundBottomCorners()
            cell.setSeparator(hidden: true)
        } else {
            cell.doNotRoundCorners()
            cell.setSeparator(hidden: false)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section
        let index = indexPath.item
        let setting = settings[section][index]
        interactor?.didTap(setting: setting)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: viewPadding, right: 0)
    }
    
}

extension SettingsView {
    
    func editProfileTapped() {
        presenter?.routeToAccountSettings()
    }
    
}

