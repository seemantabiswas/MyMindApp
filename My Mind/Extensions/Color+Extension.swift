//
//  Color+Extension.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import UIKit

extension UIColor {
    static var brandWhite: UIColor {
        return UIColor(named: "brandWhiteColor") ?? .white
    }
    
    static var brandBlack: UIColor {
        return UIColor(named: "brandBlack") ?? .black
    }
    
    static var brandPink: UIColor {
        return UIColor(named: "pinkColor") ?? .systemPink
    }
    
    static var brandPurple: UIColor {
        return UIColor(named: "purpleColor") ?? .purple
    }
}
