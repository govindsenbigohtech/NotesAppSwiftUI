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
    
    let colors: [UIColor] = [
        UIColor(named: "appFaceColor")!,
        UIColor(named: "appLightGreen")!,
        UIColor(named: "appLightYellow")!,
        UIColor(named: "appPink")!,
        UIColor(named: "appPurple")!,
        UIColor(named: "appSky")!
    ]
    
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
        
        titleLabel.font = UIFont.font(family: .nunito, sizeFamily: .regular, size: 35)
        titleLabel.textColor = .appGray
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        bodyLabel.font = UIFont.font(family: .nunito, sizeFamily: .regular, size: 23)
        bodyLabel.textColor = .appGray
        bodyLabel.numberOfLines = 1
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
        containerView.backgroundColor = .background
    }
    
    func configureCell(note: Note) {
        titleLabel.text = note.title
        bodyLabel.text = note.body
        
        containerView.backgroundColor = randomColor()
    }
    
    private func randomColor() -> UIColor {
        return colors.randomElement() ?? UIColor.white
    }
}
