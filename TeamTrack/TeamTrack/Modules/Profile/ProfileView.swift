//
//  ProfileView.swift
//  TeamTrack
//
//  Created by Maria Zaha on 5/2/24.
//

import UIKit

/*
 
 Owner
    - Create Project
        - Name
        - Tasks
        - Status
        - Assignees
    - Existing Projects
        - Comment
        - Update Status
        - Edit
 
 Employee
    - No projects yet
    - Current Projects
        - Comment
 
 */

class ProfileView: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Navigation -
    lazy var navStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 16.0
        view.clipsToBounds = false
        return view
    }()

    lazy var settingsButton : UIButton = {
        let moreButton = UIButton(type: .system)
        moreButton.tintColor = ColorService.tintColor()
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.clipsToBounds = true
        moreButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        moreButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        return moreButton
    }()
    
    lazy var createProjectButton : UIButton = {
        let moreButton = UIButton(type: .system)
        moreButton.tintColor = ColorService.tintColor()
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.clipsToBounds = true
        moreButton.setImage(UIImage(systemName: "doc.fill.badge.plus"), for: .normal)
        moreButton.addTarget(self, action: #selector(createProjectTapped), for: .touchUpInside)
        return moreButton
    }()
    
    lazy private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - View -
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
    
    lazy private var noDataView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let noDataStackSpacing: CGFloat = -6.0
    lazy private var noDataStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = noDataStackSpacing
        view.alignment = .center
        view.distribution = .fill
        return view
    }()
    
    lazy private var noDataIllustrationImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = IconService.illustration.noData
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy private var noDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No projects at this time..."
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = ColorService.placeholder()
        label.textAlignment = .center
        return label
    }()
    
    private let imageSize = CGSize(width: 300.0, height: 300.0)
    lazy private var illustrationImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = IconService.illustration.profileSignIn
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let signUpButtonSize = CGSize(width: 250.0, height: 45.0)
    lazy private var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(ColorService.prominentButtonTitleColor(), for: .normal)
        button.backgroundColor = ColorService.tintColor()
        button.layer.cornerRadius = signUpButtonSize.height / 2
        button.clipsToBounds = true
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter?.routeToSignUp()
        }), for: .touchUpInside)
        return button
    }()
    
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
    
    // Signed In
    lazy private var businessHandleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = ColorService.placeholder()
        label.isHidden = true
        return label
    }()
    
    // Projects
    private let collectionViewSpacing: CGFloat = 16.0
    lazy private var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = collectionViewSpacing
        layout.minimumInteritemSpacing = collectionViewSpacing
        return layout
    }()
    
    private let projectReuseIdentifier = "programCell"
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    lazy private var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.register(ProjectCell.self, forCellWithReuseIdentifier: projectReuseIdentifier)
        view.isScrollEnabled = true
        view.contentInset = UIEdgeInsets(top: viewPadding, left: 0.0, bottom: viewPadding, right: 0.0)
        view.alwaysBounceVertical = true
        return view
    }()
    
    var presenter: ProfilePresenterProtocol?
    var interactor: ProfileInteractorProtocol?
    var projects: [Project] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObservers()
        configureNavigation()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func configureObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(authenticationStateChanged), name: .authenticationStateChanged, object: nil)
    }

    @objc private func authenticationStateChanged() {
       // refreshView()
    }
    
    private func refreshView() {
        interactor?.computeViewTitle()
        interactor?.computeNavigationButtons()
        interactor?.computeProfileView()
        refreshProjects()
    }

}

// Navigation
extension ProfileView {
    
    func configureNavBar() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = ColorService.tintColor()
        navigationController?.view.backgroundColor = .clear
        
        let barItem = UIBarButtonItem(customView: navStackView)
        navigationItem.rightBarButtonItem = barItem
    }
    
    func addSettingsButton() {
        settingsButton.removeFromSuperview()
        settingsButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        settingsButton.heightAnchor.constraint(equalTo: settingsButton.widthAnchor).isActive = true
        
        navStackView.addArrangedSubview(settingsButton)
    }
    
    func addCreateProjectButton() {
        createProjectButton.removeFromSuperview()
        createProjectButton.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        createProjectButton.heightAnchor.constraint(equalTo: createProjectButton.widthAnchor).isActive = true
        
        navStackView.insertArrangedSubview(createProjectButton, at: 0)
    }
    
    func removeNavBarButtons() {
        for subview in navStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
    }
    
    @objc private func settingsTapped() {
        presenter?.routeToSettings()
    }
    
    @objc private func createProjectTapped() {
        presenter?.routeToCreateProject()
    }
    
    @objc private func refreshProjects() {
        interactor?.computeProjects()
    }
    
}

extension ProfileView {

    private func configureView() {
        view.backgroundColor = ColorService.systemBackground()
        
        interactor?.computeProfileView()
    }
    
    func configureSignedInState() {
        configureScrollView()
        configureStackView()
//        configureBusinessHandle()
    }
    
    func configureSignedOutState() {
        projects.removeAll()
        removeCollectionView()
        
        configureScrollView()
        configureStackView()
        configureIllustration()
        configureSignUpButton()
        configureSignInButton()
    }
    
    private func configureNavigation() {
        configureNavBar()
        interactor?.computeViewTitle()
        interactor?.computeNavigationButtons()
    }
    
    func set(viewTitle: String) {
        title = viewTitle
    }
    
    private func configureScrollView() {
        scrollView.removeFromSuperview()
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    private func emptyStackView() {
        for arrangedSubview in stackView.arrangedSubviews {
            arrangedSubview.removeFromSuperview()
        }
    }
    
    private func configureStackView() {
        emptyStackView()
        scrollView.addSubview(stackView)
        
        let viewWidth = view.frame.size.width - 2 * viewPadding
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: viewPadding),
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
    
    private func addNoData() {
        stackView.addArrangedSubview(noDataView)
        noDataView.addSubview(noDataStack)
        noDataStack.addArrangedSubview(noDataIllustrationImageView)
        noDataStack.addArrangedSubview(noDataLabel)

        NSLayoutConstraint.activate([
            noDataView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            noDataView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 5 / 4),
            
            noDataIllustrationImageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            noDataIllustrationImageView.heightAnchor.constraint(equalToConstant: imageSize.height),
            
            noDataStack.centerXAnchor.constraint(equalTo: noDataView.centerXAnchor),
            noDataStack.centerYAnchor.constraint(equalTo: noDataView.centerYAnchor)
        ])
    }
    
    private func removeNoData() {
        noDataView.removeFromSuperview()
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
}

extension ProfileView {
    private func configureBusinessHandle() {
        stackView.addArrangedSubview(businessHandleLabel)
        
        let viewWidth = view.frame.size.width - 2 * viewPadding
        NSLayoutConstraint.activate([
            businessHandleLabel.widthAnchor.constraint(equalToConstant: viewWidth)
        ])
        
        interactor?.computeBusinessHandle()
    }
    
    func set(businessHandle: String) {
        businessHandleLabel.text = businessHandle
        businessHandleLabel.isHidden = false
    }
}

extension ProfileView {
    func startActivityIndicator() {
        activityIndicator.startAnimating()
        navStackView.insertArrangedSubview(activityIndicator, at: 0)
    }
    
    func endActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    func set(projects: [Project]) {
        self.projects = projects
        guard !projects.isEmpty else {
            removeCollectionView()
            addNoData()
            return
        }
        emptyStackView()
        scrollView.removeFromSuperview()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        removeCollectionView()
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: viewPadding),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -viewPadding),
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
        
        collectionView.reloadData()
    }
    
    func removeCollectionView() {
        collectionView.removeFromSuperview()
    }
}

extension ProfileView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = view.frame.size.width - 2 * viewPadding
        let cellHeight = ProjectCell.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: projectReuseIdentifier, for: indexPath) as? ProjectCell else {
            return UICollectionViewCell()
        }
        
        let index = indexPath.item
        let project = projects[index]
        cell.set(project)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let project = projects[index]
        presenter?.routeTo(project: project)
    }
}
