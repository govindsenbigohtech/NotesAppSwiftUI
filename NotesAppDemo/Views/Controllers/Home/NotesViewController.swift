//
//  SecondViewController.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 12/12/24.

import UIKit
import CoreData

class NotesViewController: UIViewController {
    
    var backButton: UIButton!
    var saveButton: UIButton!
    var editButton: UIButton!
    var titleTextField: UITextView!
    var bodyTextField: UITextView!
    
    let titlePlaceholder = "Title"
    let bodyPlaceholder = "Type something..."
    
    var isEditingMode: Bool = false
    var isNewNote: Bool = false
    
    var coreDataManager: CoreDataManager
    var onSave: ((String, String) -> Void)?
    var noteToEdit: Note?
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if isNewNote {
            titleTextField.isEditable = true
            bodyTextField.isEditable = true
            titleTextField.text = titlePlaceholder
            bodyTextField.text = bodyPlaceholder
            saveButton.isHidden = false
            editButton.isHidden = true
        } else if let note = noteToEdit {
            titleTextField.text = note.title
            bodyTextField.text = note.body
            titleTextField.isEditable = false
            bodyTextField.isEditable = false
            saveButton.isHidden = true
            editButton.isHidden = false
        }
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
        
        saveButton = UIButton()
        saveButton.setImage(UIImage(named: "save"), for: .normal)
        saveButton.setTitleColor(.background, for: .normal)
        saveButton.backgroundColor = .clear
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            saveButton.widthAnchor.constraint(equalToConstant: 50),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.isHidden = true
        
        editButton = UIButton()
        editButton.setImage(UIImage(named: "edit"), for: .normal)
        editButton.setTitleColor(.background, for: .normal)
        editButton.backgroundColor = .clear
        editButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editButton)
        
        NSLayoutConstraint.activate([
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            editButton.widthAnchor.constraint(equalToConstant: 50),
            editButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        titleTextField = UITextView()
        titleTextField.text = "Title"
        titleTextField.textColor = .appLightGray
        titleTextField.font = UIFont.font(family: .nunito, sizeFamily: .regular, size: 48)
        titleTextField.backgroundColor = .black
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.delegate = self
        view.addSubview(titleTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        bodyTextField = UITextView()
        bodyTextField.text = "Type something..."
        bodyTextField.textColor = .appLightGray
        bodyTextField.font = UIFont.font(family: .nunito, sizeFamily: .regular, size: 23)
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
    
    @objc func editButtonTapped() {
        isEditingMode.toggle()
        
        if isEditingMode {
            // Enable editing
            titleTextField.isEditable = true
            bodyTextField.isEditable = true
            editButton.setImage(UIImage(named: "save"), for: .normal)
            saveButton.isHidden = false
        } else {
            // Disable editing and save changes
            titleTextField.isEditable = false
            bodyTextField.isEditable = false
            editButton.setImage(UIImage(named: "edit"), for: .normal)
            saveButton.isHidden = true
            
            // Show the alert for saving changes
            let title = titleTextField.text ?? ""
            let body = bodyTextField.text ?? ""
            showSaveAlert(title: title, body: body)
        }
    }
    
    @objc func saveButtonTapped() {
        let title = titleTextField.text ?? ""
        let body = bodyTextField.text ?? ""
        showSaveAlert(title: title, body: body)
    }
    
    private func showSaveAlert(title: String, body: String) {
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let alertView = UIView()
        alertView.backgroundColor = .appGray
        alertView.layer.cornerRadius = 10
        alertView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertView)
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 300),
            alertView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "info")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 41),
            imageView.widthAnchor.constraint(equalToConstant: 36),
            imageView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        let label = UILabel()
        label.text = "Save changes?"
        label.font = UIFont.font(family: .nunito, sizeFamily: .regular, size: 23)
        label.textColor = .background
        label.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
        
        let discardButton = UIButton()
        discardButton.setTitle("Discard", for: .normal)
        discardButton.setTitleColor(.background, for: .normal)
        discardButton.backgroundColor = .appRed
        discardButton.layer.cornerRadius = 5
        discardButton.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(discardButton)
        
        NSLayoutConstraint.activate([
            discardButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            discardButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
            discardButton.widthAnchor.constraint(equalToConstant: 120),
            discardButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let saveButtonInAlert = UIButton()
        saveButtonInAlert.setTitle("Save", for: .normal)
        saveButtonInAlert.setTitleColor(.background, for: .normal)
        saveButtonInAlert.backgroundColor = UIColor(named: "appGreen")
        saveButtonInAlert.layer.cornerRadius = 5
        saveButtonInAlert.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(saveButtonInAlert)
        
        NSLayoutConstraint.activate([
            saveButtonInAlert.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
            saveButtonInAlert.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
            saveButtonInAlert.widthAnchor.constraint(equalToConstant: 120),
            saveButtonInAlert.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        saveButtonInAlert.addTarget(self, action: #selector(saveButtonInAlertTapped), for: .touchUpInside)
        discardButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc func saveButtonInAlertTapped() {
        let title = titleTextField.text ?? ""
        let body = bodyTextField.text ?? ""
        
        coreDataManager.saveNote(title: title, body: body, note: noteToEdit)
        
        onSave?(title, body)
        
        for subview in view.subviews {
            if subview.backgroundColor == UIColor.lightGray.withAlphaComponent(0.8) || subview.backgroundColor == .appGray {
                subview.removeFromSuperview()
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissView() {
        for subview in view.subviews {
            if subview.backgroundColor == UIColor.lightGray.withAlphaComponent(0.8) || subview.backgroundColor == .appGray {
                subview.removeFromSuperview()
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc func backButtonTapped() {
        let title = titleTextField.text ?? ""
        let body = bodyTextField.text ?? ""
        showSaveAlert(title: title, body: body)
        
    }
}

extension NotesViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == titleTextField {
            if textView.text == "Title" {
                textView.text = ""
                textView.textColor = .background
            }
        } else if textView == bodyTextField {
            if textView.text == "Type something..." {
                textView.text = ""
                textView.textColor = .background
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == titleTextField {
            if textView.text.isEmpty {
                textView.text = "Title"
                textView.textColor = .appLightGray
            }
        } else if textView == bodyTextField {
            if textView.text.isEmpty {
                textView.text = "Type something..."
                textView.textColor = .appLightGray
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
