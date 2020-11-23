//
//  DateFormatter.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import UIKit

class ErrorAlert {
    
    static func alert(from error: String) -> UIAlertController {
        let alert = UIAlertController(title: NSLocalizedString("errorTitle", comment: ""), message: error, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: NSLocalizedString("okey", comment: ""), style: .cancel, handler: nil)
        alert.addAction(dismissAction)
        return alert
    }
}
