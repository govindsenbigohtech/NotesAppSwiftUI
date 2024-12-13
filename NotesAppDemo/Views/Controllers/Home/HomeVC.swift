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
    var searchImage: UIImageView!
    var infoImage: UIImageView!
    let tableView = UITableView()
    var coreDataManager: CoreDataManager!
    
    var notes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.getPersistentContainer()
        coreDataManager = CoreDataManager(persistentContainer: persistentContainer)
        
        self.setupUI()
        self.setupTableView()
        addButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        // Fetch notes after initializing coreDataManager
        fetchNotes()
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

        let noteLabel = UILabel()
        noteLabel.text = "Create your first note !"
        noteLabel.font = UIFont(name: "Nunito-Regular", size: 20)
        noteLabel.textAlignment = .center
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noteLabel)

        NSLayoutConstraint.activate([
            noteLabel.centerXAnchor.constraint(equalTo: notesImageView.centerXAnchor),
            noteLabel.topAnchor.constraint(equalTo: notesImageView.bottomAnchor, constant: 5),
            noteLabel.widthAnchor.constraint(equalToConstant: 250)
        ])

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
        notesLabel.font = UIFont(name: "Nunito-Regular", size: 43)
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notesLabel)

        NSLayoutConstraint.activate([
            notesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            notesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 47),
            notesLabel.widthAnchor.constraint(equalToConstant: 115),
            notesLabel.heightAnchor.constraint(equalToConstant: 59)
        ])

        searchImage = UIImageView()
        searchImage.image = UIImage(named: "search")
        searchImage.contentMode = .scaleAspectFit
        searchImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchImage)

        infoImage = UIImageView()
        infoImage.image = UIImage(named: "info_outline")
        infoImage.contentMode = .scaleAspectFit
        infoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoImage)

        NSLayoutConstraint.activate([
            searchImage.trailingAnchor.constraint(equalTo: infoImage.leadingAnchor, constant: -10),
            searchImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            searchImage.widthAnchor.constraint(equalToConstant: 30),
            searchImage.heightAnchor.constraint(equalToConstant: 30),
            infoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            infoImage.widthAnchor.constraint(equalToConstant: 30),
            infoImage.heightAnchor.constraint(equalToConstant: 30)
        ])
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

        fetchNotes()
    }
    
    private func fetchNotes() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try coreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
            tableView.reloadData() // Reload the table view after fetching notes
        } catch {
            print("Error fetching notes: \(error)")
        }
    }
    
    @objc func plusButtonTapped() {
        let secondVC = NotesViewController(coreDataManager: coreDataManager)
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
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle note selection if needed
    }
}
