//
//  Extensions.swift
//  FetchRewards
//
//  Created by Lawrence Dizon on 6/13/21.
//

import UIKit

//MARK: - Download images asynchronously
extension UIImageView {
    func url(_ url: String?) {
        DispatchQueue.global().async { [weak self] in
            guard let stringURL = url, let url = URL(string: stringURL) else {
                return
            }
            func setImage(image:UIImage?) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    setImage(image: image)
                }
            }else {
                setImage(image: nil)
            }
        }
    }
}


