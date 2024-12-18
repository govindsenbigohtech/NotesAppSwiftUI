//
//  SplashVC.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 11/12/24.
//

import UIKit

class SplashVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemPink
        
        let titleLabel = UILabel()
        titleLabel.text = "Notes App"
        titleLabel.textColor = UIColor(named: "appGray")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
            let vc = HomeVC.instantiate()
            UIStoryboard.makeNavigationControllerAsRootVC(vc)
        }
    }
}

