//
//  NavigationConfirming.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import Foundation


import UIKit

public protocol NavigationConfirming: AnyObject { }

public extension NavigationConfirming where Self: UIViewController  {
    
    /// create  a custome header  for the view
    func configureNavigationBar() {
        let logo = UIImage(named: "Icon_navbar_Logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.backgroundColor = .brandPurple
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = .brandWhite

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.brandWhite]
        

    }
}




