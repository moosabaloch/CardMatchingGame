//
//  UIView+Ext.swift
//  MatchingGame
//
//  Created by Moosa Baloch on 22/08/2021.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
