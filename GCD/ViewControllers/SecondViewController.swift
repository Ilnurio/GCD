//
//  SecondViewController.swift
//  GCD
//
//  Created by Ilnur on 20.09.2023.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
    }
}

 // MARK: - fetchImage
extension SecondViewController {
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://cardana.ru/img/auto/tagaz/hyundai_accent/hyundai_accent_1b.jpg")

        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL,
                  let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}

 // MARK: - allertLogin
extension SecondViewController {
    fileprivate func loginAlert() {
        let ac = UIAlertController(
            title: "Are you log in?",
            message: "Add your login and password",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        ac.addTextField { usernameTF in
            usernameTF.placeholder = "Add login"
        }
        
        ac.addTextField { userPasswordTF in
            userPasswordTF.placeholder = "Add password"
            userPasswordTF.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true)
    }
}

 // MARK: - delayQueue
extension SecondViewController {
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
}
