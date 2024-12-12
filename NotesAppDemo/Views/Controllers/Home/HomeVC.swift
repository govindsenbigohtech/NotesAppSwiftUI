//
//  HomeVC.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 11/12/24.
//

import UIKit

class HomeVC: UIViewController {
    var notesImageView: UIImageView!
    var addButton: UIButton!
    var notesLabel: UILabel!
    var image1: UIImageView!
    var image2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)

    }
    
    private func setupUI() {
        notesImageView = UIImageView()
        
        notesImageView.image = UIImage(named: "notesImg")
        notesImageView.contentMode = .scaleAspectFit
        notesImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(notesImageView)
        
        NSLayoutConstraint.activate([
            notesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notesImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            notesImageView.widthAnchor.constraint(equalToConstant: 350),
            notesImageView.heightAnchor.constraint(equalToConstant: 280)
        ])
        addButton = UIButton()
        
//              addButton.setTitle("+", for: .normal)
        addButton.setImage(UIImage(named: "add"), for: .normal)

        addButton.setTitleColor(.label, for: .normal)
        addButton.backgroundColor = .label
               addButton.layer.cornerRadius = 35
               addButton.translatesAutoresizingMaskIntoConstraints = false
               view.addSubview(addButton)
       
               NSLayoutConstraint.activate([
                   addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                   addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                   addButton.widthAnchor.constraint(equalToConstant: 70),
                   addButton.heightAnchor.constraint(equalToConstant: 70)
               ])
        
                notesLabel = UILabel()
        notesLabel.text = "Notes"
        notesLabel.font = UIFont(name: "Nunito-Regular", size: 43)
                notesLabel.translatesAutoresizingMaskIntoConstraints = false
        
                view.addSubview(notesLabel)
        
                NSLayoutConstraint.activate([
                    notesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                    notesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 47),
                    notesLabel.widthAnchor.constraint(equalToConstant: 115),
                       notesLabel.heightAnchor.constraint(equalToConstant: 59)
                ])
        
                image1 = UIImageView()
        
                image1.image = UIImage(named: "search")
                image1.contentMode = .scaleAspectFit
                image1.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(image1)
        
                image2 = UIImageView()
        
                image2.image = UIImage(named: "info_outline")
                image2.contentMode = .scaleAspectFit
                image2.translatesAutoresizingMaskIntoConstraints = false
        
                view.addSubview(image2)
        
                NSLayoutConstraint.activate([
                    image1.trailingAnchor.constraint(equalTo: image2.leadingAnchor, constant: -10),
                    image1.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
                    image1.widthAnchor.constraint(equalToConstant: 30),
                    image1.heightAnchor.constraint(equalToConstant: 30),
                    image2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    image2.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
                    image2.widthAnchor.constraint(equalToConstant: 30),
                    image2.heightAnchor.constraint(equalToConstant: 30)
                ])
        
    }
    @objc func plusButtonTapped() {
            let secondVC = SecondViewController()
            secondVC.modalPresentationStyle = .fullScreen
            present(secondVC, animated: true, completion: nil)
        }
    
    class func instantiate() -> HomeVC {
        let vc = UIStoryboard.home.instanceOf(viewController: HomeVC.self)!
        return vc
    }
}

