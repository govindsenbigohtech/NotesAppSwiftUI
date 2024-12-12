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
    var titleTextField: UITextView!
    var bodyTextField: UITextView!
    
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
        
        titleTextField = UITextView()
        titleTextField.text = "Title"
        titleTextField.textColor = .lightGray
        titleTextField.font = UIFont(name: "Nunito", size: 48)
        titleTextField.backgroundColor = .black
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.delegate = self
        
        view.addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        bodyTextField = UITextView()
        bodyTextField.text = "Type something..."
        bodyTextField.textColor = .lightGray
        bodyTextField.font = UIFont(name: "Nunito", size: 23)
        bodyTextField.backgroundColor = .black
        bodyTextField.translatesAutoresizingMaskIntoConstraints = false
        bodyTextField.delegate = self
        
        view.addSubview(bodyTextField)
        
        NSLayoutConstraint.activate([
            bodyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bodyTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            bodyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bodyTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == titleTextField {
            if textView.text == "Title" {
                textView.text = ""
                textView.textColor = .white
            }
        } else if textView == bodyTextField {
            if textView.text == "Type something..." {
                textView.text = ""
                textView.textColor = .white
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == titleTextField {
            if textView.text.isEmpty {
                textView.text = "Title"
                textView.textColor = .lightGray
            }
        } else if textView == bodyTextField {
            if textView.text.isEmpty {
                textView.text = "Type something..."
                textView.textColor = .lightGray
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
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
}

