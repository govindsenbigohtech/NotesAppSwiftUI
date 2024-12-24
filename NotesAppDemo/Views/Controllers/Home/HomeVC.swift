//
//  HomeVC.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 11/12/24.
//

import UIKit
import SwiftUI

class HomeVC: UIViewController {
    private var viewModel: HomeViewModel!
    private var hostingController: UIHostingController<HomeView>!
    
        class func instantiate() -> HomeVC {
            let vc = UIStoryboard.home.instanceOf(viewController: HomeVC.self)!
            return vc
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "appBlack")

        // Initialize ViewModel
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.getPersistentContainer()
        let coreDataManager = CoreDataManager(persistentContainer: persistentContainer)
        viewModel = HomeViewModel(coreDataManager: coreDataManager)

        // SwiftUI View
        let homeView = HomeView(
            notes: .constant(viewModel.notes),
            onAddNote: { [weak self] in self?.addNote() },
            onSearch: { [weak self] in self?.searchNotes() },
            onDelete: { [weak self] index in self?.deleteNoteAt(index) },
            onSelectNote: { [weak self] index in self?.selectNoteAt(index) }
        )

        hostingController = UIHostingController(rootView: homeView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        viewModel.fetchNotes()
        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.onNotesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.updateSwiftUIView()
            }
        }
    }

    private func updateSwiftUIView() {
        hostingController.rootView = HomeView(
            notes: .constant(viewModel.notes),
            onAddNote: { [weak self] in self?.addNote() },
            onSearch: { [weak self] in self?.searchNotes() },
            onDelete: { [weak self] index in self?.deleteNoteAt(index) },
            onSelectNote: { [weak self] index in self?.selectNoteAt(index) }
        )
    }

    private func addNote() {
        let notesVC = NotesViewController(coreDataManager: viewModel.coreDataManager)
        notesVC.isNewNote = true
        notesVC.onSave = { [weak self] title, body in
            self?.viewModel.addNote(title: title, body: body)
        }
        navigationController?.pushViewController(notesVC, animated: true)
    }

    private func searchNotes() {
        let searchVC = SearchViewController()
        searchVC.updateNotes(viewModel.notes)
        searchVC.modalPresentationStyle = .fullScreen
        present(searchVC, animated: true, completion: nil)
    }

    private func deleteNoteAt(_ index: Int) {
        viewModel.deleteNote(at: index)
    }

    private func selectNoteAt(_ index: Int) {
        let selectedNote = viewModel.notes[index]
        let notesVC = NotesViewController(coreDataManager: viewModel.coreDataManager)
        notesVC.noteToEdit = selectedNote
        notesVC.isNewNote = false
        notesVC.onSave = { [weak self] _, _ in
            self?.viewModel.fetchNotes()
        }
        navigationController?.pushViewController(notesVC, animated: true)
    }
}


