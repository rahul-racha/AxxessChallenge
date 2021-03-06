//
//  UIExtensions.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/30/21.
//

import UIKit

extension UILabel {
    static func getDefault(isBold: Bool = false,
                           size: CGFloat = 14,
                           textColor: UIColor = UIColor.darkGray,
                           lines: Int = 1,
                           textAlignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.font = isBold ? UIFont(name: "Helvetica-Bold", size: size) :
            UIFont(name: "Helvetica", size: size)
        label.textColor = textColor
        label.numberOfLines = lines
        label.textAlignment = textAlignment
        return label
    }
}

extension UIStackView {
    static func getDefault() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }
}
