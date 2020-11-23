//
//  NetworkImage.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import UIKit

extension UIImageView {
    
    // This is to fetch image from network
    // if the image url is not available in API it will retrun local image stored in the assets
    func download(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else {
            self.image = UIImage(named: "Background_channelheader_Science")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
