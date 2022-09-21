//
//  HomeViewController.swift
//  CREDAssignment
//
//  Created by Vishal Bhogal on 16/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    private var homeViewModel: HomeViewable
    
    init(homeViewModel: HomeViewable) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.primaryBlueColor
        view.layer.borderColor = UIColor.mustardColor.cgColor
        view.layer.borderWidth = 0.3
        view.layer.cornerRadius = 5
        tableView.backgroundColor = UIColor.primaryBlueColor
        setupView()
    }
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImage(named: "homeScreenBackground")!
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.accessibilityIdentifier = "submitButton"
        button.titleLabel?.font = UIFont.signikaregularSmall
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor.lightGray
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var XmenHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "X-MEN"
        label.textColor = UIColor.mustardColor
        label.font = UIFont.signikaBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // setupNavigationBar()
        setupSubmitButtonTapActions()
    }
    
    private func setupNavigationBar() {
        title = "X-Men"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func setupSubmitButtonTapActions() {
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .allEvents)
    }
    
    @objc func submitButtonTapped() {
        let alertController = UIAlertController(title: "Confirm Submit",
                                                message: "Thanks for submitting the details.",
                                                preferredStyle: .alert)
        let editFormAlertAction = UIAlertAction(title: "Edit", style: .destructive)
        let doneFormAlertAction = UIAlertAction(title: "Submit", style: .default) { [unowned self] alertAction in
            self.bannerNotification(text: "Your account has been registered!")
        }
        
        alertController.addAction(editFormAlertAction)
        alertController.addAction(doneFormAlertAction)
        
        
        self.navigationController?.present(alertController, animated: true)
    }
    
    // MARK: Constraints for the HomeViewController
    private func setupView() {
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(XmenHeaderLabel)
        view.addSubview(tableView)
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            
            XmenHeaderLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            XmenHeaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: XmenHeaderLabel.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            submitButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 130),
            submitButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

// MARK: Table View DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell()
        let cellType = homeViewModel.cellTypes[indexPath.row]
        switch cellType {
        case .selectYourCharacter:
            if let state = homeViewModel.selectedRows[cellType] {
                let currentState: CellState = state ? .expanded : .collapsed
                let commonModuleStackView: CommonModuleStackViewable = CommonModuleStackView()
                let customView = commonModuleStackView.configureStackView(titleLabelText: .selectYourNameTitleText,
                                                                          subtitleLabelText: .selectYourNameSubtitleText,
                                                                          state: currentState,
                                                                          cellType: cellType)
                cell.configure(customView: customView)
            }
            return cell
            
        case .selectYourAvatar:
            if let state = homeViewModel.selectedRows[cellType] {
                let currentState: CellState = state ? .expanded : .collapsed
                let commonModuleStackView: CommonModuleStackViewable = CommonModuleStackView()
                let customView = commonModuleStackView.configureStackView(titleLabelText: .selectYourAvatarTitleText,
                                                                          subtitleLabelText: .selectYourAvatarSubtitleText,
                                                                          state: currentState,
                                                                          cellType: cellType)
                cell.configure(customView: customView)
            }
            return cell
            
        case .confirmDetails:
            if let state = homeViewModel.selectedRows[cellType] {
                let currentState: CellState = state ? .expanded : .collapsed
                let commonModuleStackView: CommonModuleStackViewable = CommonModuleStackView()
                let customView = commonModuleStackView.configureStackView(titleLabelText: .confirmDetailsTitleText,
                                                                          subtitleLabelText: .confirmDetailsSubtitleText,
                                                                          state: currentState,
                                                                          cellType: cellType)
                cell.configure(customView: customView)
            }
            return cell
        }
        
    }
}

// MARK: Table View Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = homeViewModel.cellTypes[indexPath.row]
        submitButton.backgroundColor = selectedRow == .confirmDetails ? .mustardColor : .lightGray
        submitButton.isUserInteractionEnabled = selectedRow == .confirmDetails
        switch selectedRow {
        case .selectYourCharacter, .selectYourAvatar, .confirmDetails:
            if let currentState = homeViewModel.selectedRows[selectedRow] {
                // MARK:  Logic to toggle the cell state
                homeViewModel.selectedRows.keys.forEach { homeViewModel.selectedRows[$0] = false}
                homeViewModel.selectedRows[selectedRow] = !currentState
            }
            
            tableView.performBatchUpdates({
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }, completion: { _ in
                tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            })
        }
    }
}


// MARK: Success Banner When Request Is Submitted
extension HomeViewController {
    private func bannerNotification(text: String) {
        let container = UIView()
        let image = UIImageView()
        let label = UILabel()
        container.frame = CGRect(x: 0, y:-100, width: self.view.frame.size.width, height: 50)
        container.backgroundColor = .mustardColor
        image.frame = CGRect(x: 15, y: 15, width: 30, height: 30)
        image.image = UIImage(named: "successIcon")
        label.frame = CGRect(x: image.bounds.maxX + 35, y: 5, width: container.frame.size.width - 100, height: 50)
        label.numberOfLines = 0
        label.font = UIFont.signikaBoldsmall
        label.text = text
        label.textColor = UIColor.primaryBlueColor
        container.addSubview(image)
        container.addSubview(label)
        UIApplication.shared.windows[0].addSubview(container)
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveLinear, animations: {
                container.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width, height: 50)
                
            }) { (finished) in
                UIView.animate(withDuration: 0.4,delay: 2.0, options: .curveLinear, animations: {
                    container.frame = CGRect(x:0, y: -100, width: self.view.frame.size.width, height: 50)
                })
            }
        }
    }
}

