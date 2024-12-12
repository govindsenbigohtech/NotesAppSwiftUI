//
//  AppButtons.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 11/12/24.
//


import UIKit


class AppUnderlineButton: UIButton {
    
    var image : UIImage? {
        didSet {
            self.setImage(image, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .appGray
        self.tintColor = .white
        self.layer.cornerRadius = 15
    }
}


