//
//  Utils.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 15/09/23.
//

import UIKit

class Utils {
    public static func createStackView(items: [UIView], axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = axis
        stack.alignment = alignment
        stack.distribution = distribution
        stack.spacing = spacing
        
        items.forEach { view in
            stack.addArrangedSubview(view)
        }
        
        return stack
    }
}
