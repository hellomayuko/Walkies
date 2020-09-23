//
//  WalkButton.swift
//  Walkies
//
//  Created by Mayuko Inoue on 9/23/20.
//

import Foundation
import UIKit

class WalkButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(named: "darkBlue") : UIColor(named: "blue")
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0.5 * bounds.size.width
    }
}
