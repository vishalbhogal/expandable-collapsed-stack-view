//
//  CustomTableViewCell.swift
//  CREDAssignment
//
//  Created by Vishal Bhogal on 17/09/22.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    func configure(customView: UIView) {
        setupView(customView: customView)
    }

    private func setupView(customView: UIView) {
        customView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
