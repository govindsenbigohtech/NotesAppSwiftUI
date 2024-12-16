//
//  SearchViewController.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 15/12/24.
//

import UIKit

class SearchViewController: UIViewController {
    var notes: [Note] = []
    var filteredNotes: [Note] = []
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let noResultsImageView = UIImageView()
    let noResultsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "chevron_left"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        searchBar.delegate = self
        searchBar.placeholder = "Search by the keyword..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.layer.cornerRadius = 30
        searchBar.layer.masksToBounds = true
        searchBar.searchTextField.backgroundColor = .appGray
        
        view.addSubview(searchBar)
        
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: "NoteCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        noResultsImageView.image = UIImage(named: "cuate")
        noResultsImageView.contentMode = .scaleAspectFit
        noResultsImageView.translatesAutoresizingMaskIntoConstraints = false
        noResultsImageView.isHidden = true
        view.addSubview(noResultsImageView)
        
        noResultsLabel.text = "File not found. Try searching again."
        noResultsLabel.textColor = .white
        noResultsLabel.textAlignment = .center
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        noResultsLabel.isHidden = true
        view.addSubview(noResultsLabel)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            searchBar.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noResultsImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noResultsImageView.widthAnchor.constraint(equalToConstant: 370),
            noResultsImageView.heightAnchor.constraint(equalToConstant: 240),
            
            noResultsLabel.topAnchor.constraint(equalTo: noResultsImageView.bottomAnchor, constant: 5),
            noResultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResultsLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            noResultsLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func updateNotes(_ notes: [Note]) {
        self.notes = notes
        self.filteredNotes = notes
        tableView.reloadData()
        updateNoResultsImageVisibility()
    }
    
    private func updateNoResultsImageVisibility() {
        let hasResults = !filteredNotes.isEmpty
        noResultsImageView.isHidden = hasResults
        noResultsLabel.isHidden = hasResults
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
                if let title = note.title?.lowercased() {
                    return title.contains(searchText.lowercased())
                }
                return false
            }
        }
        tableView.reloadData()
        updateNoResultsImageVisibility()
    }
}
