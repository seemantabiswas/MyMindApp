//
//  BrandFont+UIFont.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import UIKit

extension UIFont {

    enum Style {
        case regular
        case bold
    }

    /// Returns a corresponding helveticaNeue font or the System font at the same size if helveticaNeue is not installed.
    static func helveticaNeue(_ style: Style = .regular, _ size: CGFloat = 14) -> UIFont {
        switch style {
        case .regular: return UIFont(name: "HelveticaNeue-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        case .bold: return UIFont(name: "HelveticaNeue-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
        }
    }

    static var titleThumbnail: UIFont {
        .helveticaNeue(.regular, 12)
    }
    
    static var titleChannel: UIFont {
        .helveticaNeue(.bold, 20)
    }
    static var titleCategory: UIFont {
        .helveticaNeue(.bold, 12)
    }
    static var body: UIFont {
        .helveticaNeue(.regular, 14)
    }
    
    static var bodyBold: UIFont {
        .helveticaNeue(.bold, 20)
    }
    
    static var description: UIFont {
        .helveticaNeue(.regular, 12)
    }
}
