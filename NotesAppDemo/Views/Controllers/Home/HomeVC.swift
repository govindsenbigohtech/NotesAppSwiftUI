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
//    var infoButton: UIButton!
    let tableView = UITableView()
    var coreDataManager: CoreDataManager!
    
    var notes: [Note] = []
    var placeholderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.getPersistentContainer()
        coreDataManager = CoreDataManager(persistentContainer: persistentContainer)
        
        self.setupUI()
        self.setupTableView()
        addButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        fetchNotes()
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
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
//        notesLabel.font = UIFont(name: "Nunito-SemiBold", size: 43)
        notesLabel.font = UIFont.font(family: .nunito, sizeFamily: .semibold, size: 43)
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notesLabel)

        NSLayoutConstraint.activate([
            notesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            notesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 47),
            notesLabel.widthAnchor.constraint(equalToConstant: 115),
            notesLabel.heightAnchor.constraint(equalToConstant: 59)
        ])
        
        // Setup search button
                searchButton = UIButton()
                searchButton.setImage(UIImage(named: "search"), for: .normal)
                searchButton.contentMode = .scaleAspectFit
                searchButton.translatesAutoresizingMaskIntoConstraints = false
                searchButton.backgroundColor = .appGray
                searchButton.layer.cornerRadius = 15
                searchButton.layer.masksToBounds = true
                view.addSubview(searchButton)

                // Adjust constraints for searchButton
                NSLayoutConstraint.activate([
                    searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
                    searchButton.widthAnchor.constraint(equalToConstant: 50),
                    searchButton.heightAnchor.constraint(equalToConstant: 50)
                ])
    }
    
    @objc func searchButtonTapped() {
        let searchVC = SearchViewController()
        searchVC.updateNotes(notes) // Pass the notes to the search view controller
        searchVC.modalPresentationStyle = .fullScreen
        present(searchVC, animated: true, completion: nil)
    }
    
    private func setupImageForPlaceholder() {
        // Create and configure the placeholder view
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
//         placeholderLabel.font = UIFont(name: "Nunito-Regular", size: 20)
        placeholderLabel.font = UIFont.font(family: .nunito, sizeFamily: .regular, size: 20)
         placeholderLabel.textAlignment = .center
         placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
         placeholderView.addSubview(placeholderLabel)

         NSLayoutConstraint.activate([
             placeholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             placeholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             placeholderView.widthAnchor.constraint(equalToConstant: 350),
             placeholderView.heightAnchor.constraint(equalToConstant: 280),

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
    
    private func fetchNotes() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try coreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
            tableView.reloadData()
            
            placeholderView.isHidden = !notes.isEmpty
            tableView.isHidden = notes.isEmpty 
        } catch {
            print("Error fetching notes: \(error)")
        }
    }
    
    @objc func plusButtonTapped() {
        let secondVC = NotesViewController(coreDataManager: coreDataManager)
        secondVC.isNewNote = true
        secondVC.onSave = { [weak self] title, body in
            self?.fetchNotes()
            self?.tableView.reloadData()
        }
        secondVC.modalPresentationStyle = .fullScreen
        present(secondVC, animated: true, completion: nil)
    }


    class func instantiate() -> HomeVC {
        let vc = UIStoryboard.home.instanceOf(viewController: HomeVC.self)!
        return vc
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        cell.configureCell(note: notes[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = notes[indexPath.row] 
        let secondVC = NotesViewController(coreDataManager: coreDataManager)
        secondVC.noteToEdit = selectedNote
        secondVC.isNewNote = false
        secondVC.onSave = { [weak self] title, body in
            self?.fetchNotes()
            self?.tableView.reloadData()
        }
        secondVC.modalPresentationStyle = .fullScreen
        present(secondVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let noteToDelete = self.notes[indexPath.row]
            
            self.coreDataManager.delete(note: noteToDelete)
            
            self.notes.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.placeholderView.isHidden = !self.notes.isEmpty
            tableView.isHidden = self.notes.isEmpty
            
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = .appRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
