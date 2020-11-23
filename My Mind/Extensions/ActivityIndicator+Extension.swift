//
//  ActivityIndicator+Extension.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import UIKit

extension UIActivityIndicatorView {
    
    func showLoader(view: UIView) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
        spinner.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        spinner.layer.cornerRadius = 3.0
        spinner.clipsToBounds = true
        spinner.hidesWhenStopped = true
        spinner.style = .medium;
        spinner.color = .brandPurple
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        view.isUserInteractionEnabled = false
        
        return spinner
    }
    
    func dismissLoader(view: UIView) {
        self.stopAnimating()
        view.isUserInteractionEnabled = true
    }
}
