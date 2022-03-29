//
//  myButton.swift
//  dicSWUnary
//
//  Created by 이규빈 on 2022/03/29.
//

import Foundation
import UIKit

class myButton: UIButton {

    override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupView()
        }

        func setupView() {
            layer.borderWidth = 1
            layer.borderColor = UIColor.darkGray.cgColor
            layer.cornerRadius = 5
            clipsToBounds = true
        }
}
