//
//  OnboardingViewController.swift
//  CREDAssignment
//
//  Created by Vishal Bhogal on 20/09/22.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    private let viewModel: HomeViewable
    
    override func viewDidLoad() {
        setBackgroundImage(imageName: "onboardingGold")
        setup()
        setupTapActions()
    }
    
    private func setBackgroundImage(imageName: String) {
        let backgroundImage = UIImage(named: imageName)
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = backgroundImage
        self.view.insertSubview(backgroundImageView, at: 0)
    }
    
    private lazy var backgroundImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "onboarding")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    init(viewModel: HomeViewable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.signikaregularSmall
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        return button
    }()
    
    private func setupTapActions() {
        getStartedButton.addTarget(self, action: #selector(getStartedButtonTapped), for: .allEvents)
    }
    
    @objc private func getStartedButtonTapped() {
        let homeViewController = HomeViewController(homeViewModel: viewModel)
        guard navigationController?.topViewController == self else { return }
        self.navigationController?.pushViewController(homeViewController, animated: false)
    }
    
    private func setup() {
        view.addSubview(getStartedButton)
        NSLayoutConstraint.activate([
            getStartedButton.widthAnchor.constraint(equalToConstant: 200),
            getStartedButton.heightAnchor.constraint(equalToConstant: 50),
            getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
}
