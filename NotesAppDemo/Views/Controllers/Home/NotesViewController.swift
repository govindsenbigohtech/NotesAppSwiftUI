//
//  SecondViewController.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 12/12/24.

import UIKit
import CoreData

class NotesViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var backButton: UIButton!
    var button1: UIButton!
    var saveButton: UIButton!
    var textField: UITextView!
    var titleTextField: UITextView!
    var bodyTextField: UITextView!
    let tableView = UITableView()
    
    var coreDataManager: CoreDataManager
    var isNotesEmpty: Bool = true
    
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
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let persistentContainer = appDelegate.getPersistentContainer()
                                    coreDataManager = CoreDataManager(persistentContainer: persistentContainer)
                                    checkNotes()
                                    //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    //               let persistentContainer = appDelegate.getPersistentContainer()
                                    //                coreDataManager = CoreDataManager(persistentContainer: persistentContainer)
                                    //
                                    }
                                    
                                    func checkNotes() {
            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
            do {
                let notes = try coreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
                if notes.count == 0 {
                    isNotesEmpty = true
                    setupUIForEmptyNotes()
                } else {
                    isNotesEmpty = false
                    setupUIForNotes()
                }
            } catch {
                print("Error fetching notes: \(error)")
            }
        }
                                    
                                    func setupUIForEmptyNotes() {
            // Hide table view and display text fields
            tableView.isHidden = true
            titleTextField.isHidden = false
            bodyTextField.isHidden = false
        }
                                    
                                    func setupUIForNotes() {
            // Hide text fields and display table view
            tableView.isHidden = false
            titleTextField.isHidden = true
            bodyTextField.isHidden = true
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
            
            saveButton = UIButton()
            saveButton.setImage(UIImage(named: "save"), for: .normal)
            saveButton.setTitleColor(.white, for: .normal)
            saveButton.backgroundColor = .clear
            saveButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(saveButton)
            
            NSLayoutConstraint.activate([
                button1.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -10),
                button1.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
                button1.widthAnchor.constraint(equalToConstant: 50),
                button1.heightAnchor.constraint(equalToConstant: 50),
                saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
                saveButton.widthAnchor.constraint(equalToConstant: 50),
                saveButton.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
            
            let titleAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Nunito", size: 48)!, .foregroundColor: UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)]
            let bodyAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Nunito", size: 23)!, .foregroundColor: UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1)]
            
            titleTextField = UITextView()
            titleTextField.text = "Title"
                                        titleTextField.textColor = .white
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
                                        bodyTextField.textColor = .white
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
                                    
                                    @objc func saveButtonTapped() {
            view.endEditing(true)
            let overlayView = UIView()
            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            overlayView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(overlayView)
            
            NSLayoutConstraint.activate([
                overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                overlayView.topAnchor.constraint(equalTo: view.topAnchor),
                overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            let alertView = UIView()
            alertView.backgroundColor = .black
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
            label.font = UIFont(name: "Nunito", size: 23)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            alertView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
                label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
            ])
            
            let discardButton = UIButton()
            discardButton.setTitle("Discard", for: .normal)
            discardButton.setTitleColor(.white, for: .normal)
            discardButton.backgroundColor = .red
            discardButton.layer.cornerRadius = 5
            discardButton.translatesAutoresizingMaskIntoConstraints = false
            alertView.addSubview(discardButton)
            
            NSLayoutConstraint.activate([
                discardButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
                discardButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
                discardButton.widthAnchor.constraint(equalToConstant: 120),
                discardButton.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            discardButton.addTarget(self, action: #selector(discardButtonTapped), for: .touchUpInside)
            
            let saveButtonInAlert = UIButton()
            saveButtonInAlert.setTitle("Save", for: .normal)
            saveButtonInAlert.setTitleColor(.white, for: .normal)
            saveButtonInAlert.backgroundColor = UIColor(red: 48/255, green: 190/255, blue: 113/255, alpha: 1)
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
            coreDataManager.saveNote(title: titleTextField.text, body: bodyTextField.text)
            
            coreDataManager.saveNote(title: titleTextField.text, body: bodyTextField.text)
            coreDataManager.fetchAllNotes()
            checkNotes()
            
        }
                                    
                                    @objc func button1Tapped() {
            view.endEditing(true)
        }
                                    
                                    @objc func discardButtonTapped() {
            for subview in view.subviews {
                if subview.backgroundColor == .black || subview.backgroundColor?.cgColor.alpha == 0.5 {
                    subview.removeFromSuperview()
                }
            }
            
            let overlayView = UIView()
            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            overlayView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(overlayView)
            
            NSLayoutConstraint.activate([
                overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                overlayView.topAnchor.constraint(equalTo: view.topAnchor),
                overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            let alertView = UIView()
            alertView.backgroundColor = .black
            alertView.layer.cornerRadius = 10
            alertView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(alertView)
            
            NSLayoutConstraint.activate([
                alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                alertView.widthAnchor.constraint(equalToConstant: 300),
                alertView.heightAnchor.constraint(equalToConstant: 250)
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
            label.text = "Are you sure you want to discard your changes?"
            label.font = UIFont(name: "Nunito", size: 23)
            label.textColor = .white
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            alertView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
                label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                label.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20)
            ])
            
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false
            alertView.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
                stackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
                stackView.widthAnchor.constraint(equalToConstant: 240)
            ])
            
            let discardButtonInAlert = UIButton()
            discardButtonInAlert.setTitle("Discard", for: .normal)
            discardButtonInAlert.setTitleColor(.white, for: .normal)
            discardButtonInAlert.backgroundColor = .red
            discardButtonInAlert.layer.cornerRadius = 5
            discardButtonInAlert.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(discardButtonInAlert)
            
            NSLayoutConstraint.activate([
                discardButtonInAlert.widthAnchor.constraint(equalToConstant: 100),
                discardButtonInAlert.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            discardButtonInAlert.addTarget(self, action: #selector(discardButtonInAlertTapped), for: .touchUpInside)
            
            let keepButton = UIButton()
            keepButton.setTitle("Keep", for: .normal)
            keepButton.setTitleColor(.white, for: .normal)
            keepButton.backgroundColor = UIColor(red: 48/255, green: 190/255, blue: 113/255, alpha: 1)
            keepButton.layer.cornerRadius = 5
            keepButton.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(keepButton)
            
            NSLayoutConstraint.activate([
                keepButton.widthAnchor.constraint(equalToConstant: 100),
                keepButton.heightAnchor.constraint(equalToConstant: 40)
            ])
            
        }
                                    
                                    @objc func cancelButtonTapped() {
            for subview in view.subviews {
                if subview.backgroundColor == .black || subview.backgroundColor?.cgColor.alpha == 0.5 {
                    subview.removeFromSuperview()
                }
            }
            
            saveButtonTapped()
        }
                                    
                                    @objc func discardButtonInAlertTapped() {
            print("Changes discarded")
            
            // Remove the alert view and the overlay view
            for subview in view.subviews {
                if subview.backgroundColor == .black || subview.backgroundColor?.cgColor.alpha == 0.5 {
                    subview.removeFromSuperview()
                }
            }
        }
                                    
                                    @objc func saveButtonInAlertTapped() {
            print("Changes saved")
            
            for subview in view.subviews {
                if subview.backgroundColor == .black || subview.backgroundColor?.cgColor.alpha == 0.5 {
                    subview.removeFromSuperview()
                }
            }
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
            view.endEditing(true)
            let notesTableViewController = NotesTableViewController(coreDataManager: coreDataManager)
            self.present(notesTableViewController, animated: true, completion: nil)
        }
                                    
                                    //    @objc func backButtonTapped() {
                                    //        view.endEditing(true)
                                    //        self.dismiss(animated: true, completion: nil)
                                    //
                                    //    }
                                    
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
                                    
                                    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
            do {
                let notes = try coreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
                return notes.count
            } catch {
                print("Error fetching notes: \(error)")
                return 0
            }
        }
                                    
                                    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
            do {
                let notes = try coreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
                cell.configureCell(note: notes[indexPath.row])
            } catch {
                print("Error fetching notes: \(error)")
            }
            return cell
        }
                                    }
                                    
                                    
                                    
