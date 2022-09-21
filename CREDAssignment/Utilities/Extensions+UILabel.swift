//
//  Extensions+UILabel.swift
//  CREDAssignment
//
//  Created by Vishal Bhogal on 20/09/22.
//

import Foundation
import UIKit

extension UILabel {
    @objc
    func input(textField: UITextField) {
        self.text = textField.text
    }

    func connect(with textField:UITextField){
        textField.addTarget(self, action: #selector(UILabel.input(textField:)), for: .editingChanged)
    }
}
