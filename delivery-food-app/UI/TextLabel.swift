//
//  TextLabel.swift
//  delivery-food-app
//
//  Created by Eugene on 9.04.23.
//

import UIKit

enum ColorStyle {
    case black
    case gray
    case lightGray
    case textGray
    case orange
    case grayOrange
    case borderColor
    case white
}

final class TextLabel: UILabel {
    private var textLabel: String
    private var color: ColorStyle
    private var weight: UIFont.Weight
    private var size: CGFloat
    private var aligment: NSTextAlignment
    private var linesNumber: Int
    
    init(label: String = "", size: CGFloat = 16, color: ColorStyle = .black, weight: UIFont.Weight = .regular, aligment: NSTextAlignment = .left, linesNumber: Int = 0) {
        self.textLabel = label
        self.size = size
        self.color = color
        self.weight = weight
        self.aligment = aligment
        self.linesNumber = linesNumber
        
        super.init(frame: .zero)
        
        self.configureLabel()
        self.configureLabelColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextLabel {
    private func configureLabelColor() {
        switch color {
        case .black:
            self.textColor = UIColor.black
        case .gray:
            self.textColor = UIColor.gray
        case .lightGray:
            self.textColor = UIColor.lightGray
        case .textGray:
            self.textColor = UIColor.textGray
        case .orange:
            self.textColor = UIColor.orange
        case .grayOrange:
            self.textColor = UIColor.grayOrange
        case .borderColor:
            self.textColor = UIColor.borderColor
        case .white:
            self.textColor = UIColor.white
        }
    }
    
    private func configureLabel() {
        self.text = textLabel
        self.numberOfLines = linesNumber
        self.textAlignment = aligment
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
}
