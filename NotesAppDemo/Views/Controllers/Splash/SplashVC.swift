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

        self.view.backgroundColor = .clear
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
            let vc = HomeVC.instantiate()
            UIStoryboard.makeNavigationControllerAsRootVC(vc)
        }
    }
}

