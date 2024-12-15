//
//  SearchViewController.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 15/12/24.
//

//import UIKit
//
//class SearchViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}
import UIKit

class SearchViewController: UIViewController {
    var notes: [Note] = []
    var filteredNotes: [Note] = []
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        // Create and configure the back button
        let backButton = UIButton(type: .system)
//        backButton.setTitle("Back", for: .normal)
        backButton.setImage(UIImage(named: "chevron_left"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        // Set up the search bar
        searchBar.delegate = self
        searchBar.placeholder = "Search by the keyword..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        // Set up the table view
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            searchBar.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
//    private func setupUI() {
//        view.backgroundColor = .white
//        
//        searchBar.delegate = self
//        searchBar.placeholder = "Search notes"
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(searchBar)
//        
//        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteCell")
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(tableView)
//        
//        NSLayoutConstraint.activate([
//            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            
//            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
    
    func updateNotes(_ notes: [Note]) {
        self.notes = notes
        self.filteredNotes = notes // Initially show all notes
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        cell.configureCell(note: filteredNotes[indexPath.row])
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredNotes = notes
        } else {
            filteredNotes = notes.filter { note in
                // Safely unwrap the title and check if it contains the search text
                if let title = note.title?.lowercased() {
                    return title.contains(searchText.lowercased())
                }
                return false // If title is nil, return false
            }
        }
        tableView.reloadData()
    }
}

//extension SearchViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            filteredNotes = notes
//        } else {
//            filteredNotes = notes.filter { note in
//                // Assuming Note has a 'title' property
//                return note.title?.lowercased().contains(searchText.lowercased())
//            }
//        }
//        tableView.reloadData()
//    }
//}