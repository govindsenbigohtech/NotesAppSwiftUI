//
//  NoteTableViewCell.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 12/12/24.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
//        titleLabel.font = UIFont(name: "Nunito", size: 23)
        titleLabel.font = UIFont.font(family: .nunito, sizeFamily: .regular, size: 35)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
//        bodyLabel.font = UIFont(name: "Nunito", size: 18)
        bodyLabel.font = UIFont.font(family: .nunito, sizeFamily: .regular, size: 23)
        bodyLabel.textColor = .black
        bodyLabel.numberOfLines = 0
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(bodyLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            bodyLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
        
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = .white
    }
    
    func configureCell(note: Note) {
        titleLabel.text = note.title
        bodyLabel.text = note.body
        
        containerView.backgroundColor = randomColor()
    }
    
    private func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
