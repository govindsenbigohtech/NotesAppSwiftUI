//
//  NoteTableViewCell.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 12/12/24.
//

import UIKit

//class NoteTableViewCell: UITableViewCell {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//}

//import UIKit
//
//class NoteTableViewCell: UITableViewCell {
//    
//    let titleLabel = UILabel()
//    let bodyLabel = UILabel()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupUI() {
//        titleLabel.font = UIFont(name: "Nunito", size: 23)
//        titleLabel.textColor = .black
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(titleLabel)
//        
//        bodyLabel.font = UIFont(name: "Nunito", size: 18)
//        bodyLabel.textColor = .black
//        bodyLabel.numberOfLines = 0
//        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(bodyLabel)
//        
//        NSLayoutConstraint.activate([
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            
//            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
//        ])
//    }
//    
//    func configureCell(note: Note) {
//        titleLabel.text = note.title
//        bodyLabel.text = note.body
//    }
//}
//import UIKit
//
//class NoteTableViewCell: UITableViewCell {
//    
//    let titleLabel = UILabel()
//    let bodyLabel = UILabel()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupUI() {
//        // Set the background color of the cell
//        contentView.backgroundColor = UIColor.blue
//        
//        // Configure titleLabel
//        titleLabel.font = UIFont(name: "Nunito", size: 23)
//        titleLabel.textColor = .white // Set text color to white
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(titleLabel)
//        
//        // Configure bodyLabel
//        bodyLabel.font = UIFont(name: "Nunito", size: 18)
//        bodyLabel.textColor = .white // Set text color to white
//        bodyLabel.numberOfLines = 0
//        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(bodyLabel)
//        
//        // Set up constraints
//        NSLayoutConstraint.activate([
//            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            
//            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
//            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
//        ])
//    }
//    
//    func configureCell(note: Note) {
//        titleLabel.text = note.title
//        bodyLabel.text = note.body
//    }
//    
//    // Override the method to set the height of the cell
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        // Set the height of the cell
//        self.frame.size.height = 110
//    }
//}
import UIKit

class NoteTableViewCell: UITableViewCell {
    
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
        // Configure titleLabel
        titleLabel.font = UIFont(name: "Nunito", size: 23)
        titleLabel.textColor = .black // Set text color to white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        // Configure bodyLabel
        bodyLabel.font = UIFont(name: "Nunito", size: 18)
        bodyLabel.textColor = .black // Set text color to white
        bodyLabel.numberOfLines = 0
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bodyLabel)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        // Set corner radius
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    func configureCell(note: Note) {
        titleLabel.text = note.title
        bodyLabel.text = note.body
        
        // Set a random background color
        contentView.backgroundColor = randomColor()
    }
    
    // Function to generate a random color
    private func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(256)) / 255.0
        let green = CGFloat(arc4random_uniform(256)) / 255.0
        let blue = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
