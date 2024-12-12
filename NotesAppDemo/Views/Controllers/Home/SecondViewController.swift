//
//  SecondViewController.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 12/12/24.

import UIKit

class SecondViewController: UIViewController, UITextViewDelegate {
    var backButton: UIButton!
    var button1: UIButton!
    var button2: UIButton!
    var textField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        backButton = UIButton()
        backButton.setImage(UIImage(named: "chevron_left"), for: .normal)

        backButton.setTitleColor(.label, for: .normal)
        backButton.backgroundColor = .clear
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        button1 = UIButton()

        button1.setImage(UIImage(named: "eyeImg"), for: .normal)
        button1.setTitleColor(.label, for: .normal)
        button1.backgroundColor = .clear
        button1.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button1)
        
        button2 = UIButton()
        
        button2.setImage(UIImage(named: "save"), for: .normal)
        button2.setTitleColor(.white, for: .normal)
        button2.backgroundColor = .clear
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button2)
        
        NSLayoutConstraint.activate([
            button1.trailingAnchor.constraint(equalTo: button2.leadingAnchor, constant: -10),
            button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            button1.widthAnchor.constraint(equalToConstant: 50),
            button1.heightAnchor.constraint(equalToConstant: 50),
            button2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button2.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            button2.widthAnchor.constraint(equalToConstant: 50),
            button2.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let titleAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Nunito", size: 48)!, .foregroundColor: UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)]
        let bodyAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Nunito", size: 23)!, .foregroundColor: UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)]

        let titleAttributedString = NSAttributedString(string: "Title\n\n", attributes: titleAttributes)
        let bodyAttributedString = NSAttributedString(string: "Type something...", attributes: bodyAttributes)

        let attributedText = NSMutableAttributedString()
        attributedText.append(titleAttributedString)
        attributedText.append(bodyAttributedString)

        textField = UITextView()
        textField.attributedText = attributedText
        textField.backgroundColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(textField)
        
//        let titleAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Nunito", size: 48)!, .foregroundColor: UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)]
//        let bodyAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.white]
//        
//        let titleAttributedString = NSAttributedString(string: "Title\n\n", attributes: titleAttributes)
//        let bodyAttributedString = NSAttributedString(string: "Type something...", attributes: bodyAttributes)
//        
//        let attributedText = NSMutableAttributedString()
//        attributedText.append(titleAttributedString)
//        attributedText.append(bodyAttributedString)
//        
//        textField = UITextView()
//        textField.attributedText = attributedText
//        textField.backgroundColor = .black
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(textField)
//        
//        NSLayoutConstraint.activate([
//            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
//            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 141),
//            textField.widthAnchor.constraint(equalToConstant: 100),
//            textField.heightAnchor.constraint(equalToConstant: 52)
//        ])
        
//        textField = UITextView()
//        
//        textField.backgroundColor = .label
//        textField.font = .systemFont(ofSize: 17)
//        textField.text = "Title\n\nType something..."
//        textField.textColor = .lightGray
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        textField.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Title\n\nType something..." {
            textView.text = ""
            textView.textColor = .white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Title\n\nType something..."
            textView.textColor = .lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            if textView.text.first == "\n" {
                textView.text = String(textView.text.dropFirst())
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func backButtonTapped() {
            self.dismiss(animated: true, completion: nil)
       }
}
