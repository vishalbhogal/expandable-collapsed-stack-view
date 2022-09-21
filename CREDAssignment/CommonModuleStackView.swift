//
//  CommonModuleStackView.swift
//  CREDAssignment
//
//  Created by Vishal Bhogal on 17/09/22.
//



import Foundation
import UIKit

//MARK: Abstraction layer for stack framework supporting expand & collapse state of view

protocol CommonModuleStackViewable: AnyObject {
    func configureStackView(titleLabelText: CellTitleString,
                            subtitleLabelText: CellSubtitleString,
                            state: CellState,
                            cellType: CellTypes) -> UIView
}

//MARK: CommonModuleStackView
class CommonModuleStackView: CommonModuleStackViewable {
    init() {
    }

    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mustardColor
        label.accessibilityIdentifier = "TitleLabel"
        label.font = UIFont.signikaBoldsmall
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var accessoryArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "accessory")?.withTintColor(.mustardColor)
        imageView.accessibilityIdentifier = "accessoryImageView"
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var headerHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.accessibilityIdentifier = "headerHorizontalStackView"
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var subTitleTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.signikaregularSmall
        label.accessibilityIdentifier = "SubtitleLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.mustardColor
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.accessibilityIdentifier = "lineView"
        return lineView
    }()
    
    private lazy var expandedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "ExpandedView"
        return stackView
    }()
    
    private lazy var collapsedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "CollapsedView"
        return stackView
    }()
    
    private lazy var fullStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.accessibilityIdentifier = "Expanded+CollapsedView"
        return stackView
    }()
    
    // MARK: Custom View For Cell in Expanded State
    private func createCustomExpandableView(cellType: CellTypes, state: CellState) -> UIStackView {
        switch (cellType, state) {
        case (.selectYourCharacter, .expanded):
             setupViewForCharacterNameCell()
            return expandableStackViewForSelectCharacter
        case (.selectYourAvatar, .expanded):
             setupViewForAvatarCell()
            return expandableStackViewForSelectAvatar
        case (.confirmDetails, .expanded):
            setupViewForConfirmDetails()
            return expandableVerticalStackViewForConfirmDetails
        case (_, .collapsed):
            return UIStackView()
        }
    }
    
    private lazy var expandableVerticalStackViewForConfirmDetails: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.accessibilityIdentifier = "confirmDetailsStackView"
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 5
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackView
    }()
    
    private lazy var expandableStackViewForSelectAvatar: UIStackView = {
        let horizontalImageStackView = UIStackView()
        horizontalImageStackView.accessibilityIdentifier = "selectAvatarImageHorizontalStackView"
        horizontalImageStackView.axis = .horizontal
        horizontalImageStackView.distribution = .fillProportionally
        horizontalImageStackView.alignment = .center
        horizontalImageStackView.spacing = 30
        horizontalImageStackView.translatesAutoresizingMaskIntoConstraints = false
        return horizontalImageStackView
    }()
    
    private lazy var expandableStackViewForSelectCharacter: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.alignment = .leading
        stackview.spacing = 8
        stackview.accessibilityIdentifier = "selectCharacterStackView"
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private lazy var optionalInfoCollapsedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.signikaBoldExtrasmall
        label.textColor = UIColor.cyan
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var textFieldToEnterName: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.signikaregularExtraSmall
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.mustardColor.cgColor
        textField.layer.borderWidth = 1
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .lightGray
        textField.textAlignment = .center
        textField.placeholder = "Magneto, Professor, Wolverine"
        textField.returnKeyType = .done
        return textField
    }()
    
    private func hideExpandedViewIfStateIsCollapsed(state: CellState, completion: ((CellState) -> Void)? = nil) {
        completion?(state)
    }
    
    
    private func setupView(cellType: CellTypes, state: CellState) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.primaryBlueColor
        let expandedView = createCustomExpandableView(cellType: cellType, state: state)
        
        headerHorizontalStackView.addArrangedSubview(headerTitleLabel)
        headerHorizontalStackView.addArrangedSubview(accessoryArrowImageView)
        
        collapsedStackView.addArrangedSubview(headerHorizontalStackView)
        collapsedStackView.addArrangedSubview(subTitleTextLabel)
        collapsedStackView.addArrangedSubview(optionalInfoCollapsedLabel)
    
        fullStackView.addArrangedSubview(collapsedStackView)
        
        if state == .expanded {
            expandedView.translatesAutoresizingMaskIntoConstraints = false
            expandedStackView.addArrangedSubview(expandedView)
            fullStackView.addArrangedSubview(expandedStackView)
        }
        
        fullStackView.addArrangedSubview(lineView)
        view.addSubview(fullStackView)

        NSLayoutConstraint.activate([
            accessoryArrowImageView.heightAnchor.constraint(equalToConstant: 20),
            accessoryArrowImageView.widthAnchor.constraint(equalToConstant: 20),
            accessoryArrowImageView.trailingAnchor.constraint(equalTo: fullStackView.trailingAnchor),
            
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.widthAnchor.constraint(equalTo: fullStackView.widthAnchor),
            
            fullStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fullStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fullStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            fullStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            
            subTitleTextLabel.heightAnchor.constraint(equalToConstant: 14),
            optionalInfoCollapsedLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        return view
    }
    
    //MARK: Setup function to configure the View
    
    func configureStackView(titleLabelText: CellTitleString,
                            subtitleLabelText: CellSubtitleString,
                            state: CellState = .collapsed,
                            cellType: CellTypes) -> UIView {
        headerTitleLabel.text = titleLabelText.rawValue
        subTitleTextLabel.text = subtitleLabelText.rawValue
        hideExpandedViewIfStateIsCollapsed(state: state) { [unowned self] state in
            // Flip Accessory Image When State is Toggled
            self.accessoryArrowImageView.transform = state == .expanded ? CGAffineTransform(rotationAngle: .pi) : .identity
        }
        return setupView(cellType: cellType, state: state)
    }
}


//MARK: ExpandableView for SelectCharacterName
extension CommonModuleStackView {
    private func setupViewForCharacterNameCell() {
        
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.alignment = .firstBaseline
        stackview.spacing = 15
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        let characterNameLabel = UILabel()
        characterNameLabel.text = "Name:"
        characterNameLabel.font = UIFont.signikaBoldsmall
        characterNameLabel.textColor = UIColor.white
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.numberOfLines = 0
        
        optionalInfoCollapsedLabel.isHidden = false
        stackview.addArrangedSubview(characterNameLabel)
        optionalInfoCollapsedLabel.connect(with: textFieldToEnterName)
        stackview.addArrangedSubview(textFieldToEnterName)
        expandableStackViewForSelectCharacter.addArrangedSubview(stackview)
        
        NSLayoutConstraint.activate([
            textFieldToEnterName.widthAnchor.constraint(equalToConstant: 180),
            textFieldToEnterName.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}

//MARK: ExpandableView for SelectAvatar
extension CommonModuleStackView {
    private func setupViewForAvatarCell() {
        let magnetoImageView = UIImageView(image: UIImage(named: "magneto"))
        let professorXimageView = UIImageView(image: UIImage(named: "Professor"))
        let wolverineImageView = UIImageView(image: UIImage(named: "wolverine"))
        
        magnetoImageView.isUserInteractionEnabled = true
        professorXimageView.isUserInteractionEnabled = true
        wolverineImageView.isUserInteractionEnabled = true
        
        magnetoImageView.accessibilityIdentifier = "magneto"
        professorXimageView.accessibilityIdentifier = "Professor"
        wolverineImageView.accessibilityIdentifier = "wolverine"
        
        magnetoImageView.setRounded(32)
        professorXimageView.setRounded(32)
        wolverineImageView.setRounded(32)
        
        magnetoImageView.selectAvatar(for: magnetoImageView)
        professorXimageView.selectAvatar(for: professorXimageView)
        wolverineImageView.selectAvatar(for: wolverineImageView)
        
        magnetoImageView.contentMode = .scaleAspectFit
        professorXimageView.contentMode = .scaleAspectFit
        wolverineImageView.contentMode = .scaleAspectFit
        
        expandableStackViewForSelectAvatar.addArrangedSubview(magnetoImageView)
        expandableStackViewForSelectAvatar.addArrangedSubview(professorXimageView)
        expandableStackViewForSelectAvatar.addArrangedSubview(wolverineImageView)
        
        expandableStackViewForSelectAvatar.translatesAutoresizingMaskIntoConstraints = false
        magnetoImageView.translatesAutoresizingMaskIntoConstraints = false
        professorXimageView.translatesAutoresizingMaskIntoConstraints = false
        wolverineImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            magnetoImageView.heightAnchor.constraint(equalToConstant: 70),
            magnetoImageView.widthAnchor.constraint(equalToConstant: 70),
            professorXimageView.heightAnchor.constraint(equalToConstant: 70),
            professorXimageView.widthAnchor.constraint(equalToConstant: 70),
            wolverineImageView.heightAnchor.constraint(equalToConstant: 70),
            wolverineImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}

//MARK: ExpandableView for ConfirmDetails
extension CommonModuleStackView {
    private func setupViewForConfirmDetails() {
        let confirmationLabel = UILabel()
        expandableVerticalStackViewForConfirmDetails.addArrangedSubview(confirmationLabel)
       
        confirmationLabel.text = "Thanks for providing the details. Press Submit and you are all set."
        confirmationLabel.accessibilityIdentifier = "confirmationLabel"
        confirmationLabel.font = UIFont.signikaregularSmall
        confirmationLabel.textColor = .white
        confirmationLabel.numberOfLines = 0
        confirmationLabel.adjustsFontForContentSizeCategory = true
       
        confirmationLabel.translatesAutoresizingMaskIntoConstraints = false
        expandableVerticalStackViewForConfirmDetails.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            confirmationLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
