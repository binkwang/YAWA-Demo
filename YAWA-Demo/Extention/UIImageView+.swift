//
//  UIImageView+.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 9/1/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    func renderImage(imageUrl: String?) {
        guard let imageUrl = imageUrl, !(imageUrl.isEmpty) else { return }
        URLSession.shared.dataTask(with: NSURL(string: imageUrl)! as URL) { [weak self] (data, response, error) -> Void in
            guard let weakSelf = self else { return }
            if let data = data {
                DispatchQueue.main.async {
                    weakSelf.image = UIImage(data: data)
                }
            }
            }.resume()
    }
}
