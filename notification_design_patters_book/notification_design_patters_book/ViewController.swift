//
//  ViewController.swift
//  notification_design_patters_book
//
//  Created by Ania on 27/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testView = UIView(frame: CGRect(x: 0, y: 0, width: 256, height: 256))
        testView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        testView.center = view.center
        view.addSubview(testView)
        testView.makeThemeable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2) {
            NotificationCenter.default.post(name: .HWSThemeDidChange, object: nil)
        }
        
    }
    
}

extension Notification.Name {
    static let HWSThemeDidChange = Notification.Name("HWSThemeDidChangeNotification")
}

extension UIView {
    @objc func makeThemeable() {
        NotificationCenter.default.addObserver(self, selector: #selector(enableDarkTheme), name: .HWSThemeDidChange, object: nil)
    }
    
    @objc func enableDarkTheme() {
        backgroundColor = UIColor(white: 0.1, alpha: 1)
    }
}
