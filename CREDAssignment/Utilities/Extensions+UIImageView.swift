//
//  Extension+UIImageView.swift
//  CREDAssignment
//
//  Created by Vishal Bhogal on 18/09/22.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setRounded(_ integerLiteral: Int) {
        let radius = CGFloat(integerLiteral: integerLiteral)
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    @objc func input() {
        if self.layer.borderColor == UIColor.mustardColor.cgColor {
            self.layer.borderColor = UIColor.white.cgColor
        } else {
            
            self.layer.borderColor = UIColor.mustardColor.cgColor
        }
    }
    
    func selectAvatar(for imageView: UIImageView) {
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIImageView.input)))
    }
}
