//
//  HomeVC.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 11/12/24.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    var notesImageView: UIImageView!
    var addButton: UIButton!
    var notesLabel: UILabel!
    var searchButton: UIButton!
    let tableView = UITableView()
    var placeholderView: UIView!
    
    private var viewModel: HomeViewModel!
    
    class func instantiate() -> HomeVC {
        let vc = UIStoryboard.home.instanceOf(viewController: HomeVC.self)!
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.getPersistentContainer()
        let coreDataManager = CoreDataManager(persistentContainer: persistentContainer)
        viewModel = HomeViewModel(coreDataManager: coreDataManager)
        
        setupUI()
        setupTableView()
        
        bindViewModel()
        
        addButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        viewModel.fetchNotes()
    }
    
    private func bindViewModel() {
        viewModel.onNotesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        
        viewModel.onError = { error in
            print(error)
        }
    }
    
    private func updateUI() {
        tableView.reloadData()
        placeholderView.isHidden = !viewModel.notes.isEmpty
        tableView.isHidden = viewModel.notes.isEmpty
    }
    
    @objc func plusButtonTapped() {
        let notesVC = NotesViewController(coreDataManager: viewModel.coreDataManager)
        notesVC.isNewNote = true
        notesVC.onSave = { [weak self] title, body in
            self?.viewModel.addNote(title: title, body: body)
        }
        notesVC.modalPresentationStyle = .fullScreen
        present(notesVC, animated: true, completion: nil)
    }
    
    @objc func searchButtonTapped() {
        let searchVC = SearchViewController()
        searchVC.updateNotes(viewModel.notes)
        searchVC.modalPresentationStyle = .fullScreen
        present(searchVC, animated: true, completion: nil)
    }
    
        private func setupUI() {
            self.setupImageForPlaceholder()
    
            addButton = UIButton()
            addButton.setImage(UIImage(named: "add"), for: .normal)
            addButton.setTitleColor(.label, for: .normal)
            addButton.backgroundColor = .clear
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
            notesLabel.font = UIFont.font(family: .nunito, sizeFamily: .semibold, size: 43)
            notesLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(notesLabel)
    
            NSLayoutConstraint.activate([
                notesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                notesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 47),
                notesLabel.widthAnchor.constraint(equalToConstant: 115),
                notesLabel.heightAnchor.constraint(equalToConstant: 59)
            ])
    
            searchButton = UIButton()
            searchButton.setImage(UIImage(named: "search"), for: .normal)
            searchButton.contentMode = .scaleAspectFit
            searchButton.translatesAutoresizingMaskIntoConstraints = false
            searchButton.backgroundColor = .appGray
            searchButton.layer.cornerRadius = 15
            searchButton.layer.masksToBounds = true
            view.addSubview(searchButton)
    
            NSLayoutConstraint.activate([
                searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
                searchButton.widthAnchor.constraint(equalToConstant: 50),
                searchButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    
        private func setupImageForPlaceholder() {
            placeholderView = UIView()
            placeholderView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(placeholderView)
    
            let placeholderImageView = UIImageView()
            placeholderImageView.image = UIImage(named: "notesImg")
            placeholderImageView.contentMode = .scaleAspectFit
            placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
            placeholderView.addSubview(placeholderImageView)
    
            let placeholderLabel = UILabel()
            placeholderLabel.text = "Create your first note!"
            placeholderLabel.font = UIFont.font(family: .nunito, sizeFamily: .regular, size: 20)
            placeholderLabel.textAlignment = .center
            placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
            placeholderView.addSubview(placeholderLabel)
    
            NSLayoutConstraint.activate([
                placeholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                placeholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                placeholderView.widthAnchor.constraint(equalToConstant: 350),
                placeholderView.heightAnchor.constraint(equalToConstant: 287),
    
                placeholderImageView.centerXAnchor.constraint(equalTo: placeholderView.centerXAnchor),
                placeholderImageView.topAnchor.constraint(equalTo: placeholderView.topAnchor),
                placeholderImageView.widthAnchor.constraint(equalTo: placeholderView.widthAnchor),
                placeholderImageView.heightAnchor.constraint(equalTo: placeholderView.heightAnchor, multiplier: 0.7),
    
                placeholderLabel.centerXAnchor.constraint(equalTo: placeholderView.centerXAnchor),
                placeholderLabel.topAnchor.constraint(equalTo: placeholderImageView.bottomAnchor, constant: 5),
                placeholderLabel.widthAnchor.constraint(equalTo: placeholderView.widthAnchor),
            ])
    
            placeholderView.isHidden = true
        }
    
    private func setupTableView() {
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -20)
        ])
        
        tableView.isHidden = true
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        cell.configureCell(note: viewModel.notes[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = viewModel.notes[indexPath.row]
        let notesVC = NotesViewController(coreDataManager: viewModel.coreDataManager)
        notesVC.noteToEdit = selectedNote
        notesVC.isNewNote = false
        notesVC.onSave = { [weak self] title, body in
            self?.viewModel.fetchNotes()
        }
        notesVC.modalPresentationStyle = .fullScreen
        present(notesVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            self?.viewModel.deleteNote(at: indexPath.row)
            completionHandler(true)
        }
        deleteAction.backgroundColor = .appRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

