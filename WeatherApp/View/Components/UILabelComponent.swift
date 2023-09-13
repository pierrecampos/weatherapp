//
//  UILabelComponent.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 12/09/23.
//

import UIKit

class UILabelComponent: UILabel {
    
    enum fontColor {
        case primary
        case secondary
    }
    
    public private(set) var labelText: String
    public private(set) var fontSize: CGFloat
    public private(set) var fontWeight: UIFont.Weight
    public private(set) var fontColor: fontColor
    
    init(labelText: String, fontSize: CGFloat, fontWeight: UIFont.Weight, fontColor: fontColor) {
        self.labelText = labelText
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.fontColor = fontColor
        
        super.init(frame: .zero)
        self.configureLabelColor()
        self.configureLabelStyle()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let attributedString = NSMutableAttributedString(string: labelText)
        self.attributedText = attributedString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabelColor() {
        switch self.fontColor {
        case .primary:
            self.textColor = UIColor.primary
        case .secondary:
            self.textColor = UIColor.secondary
        }
    }
    
    private func configureLabelStyle() {
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.lineBreakMode = .byTruncatingTail
        self.textAlignment = .center
    }
}
