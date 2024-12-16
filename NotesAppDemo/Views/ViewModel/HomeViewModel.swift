//
//  HomeViewModel.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 16/12/24.
//


import Foundation
import CoreData

class HomeViewModel {
    let coreDataManager: CoreDataManager
    private(set) var notes: [Note] = []
    
    // Binding for data updates
    var onNotesUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func fetchNotes() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try coreDataManager.persistentContainer.viewContext.fetch(fetchRequest)
            onNotesUpdated?()
        } catch {
            onError?("Error fetching notes: \(error.localizedDescription)")
        }
    }
    
    func addNote(title: String, body: String) {
        coreDataManager.saveNote(title: title, body: body) // Use saveNote instead of create
        fetchNotes()
    }

//    func addNote(title: String, body: String) {
//        coreDataManager.create(title: title, body: body)
//        fetchNotes()
//    }
    
    func deleteNote(at index: Int) {
        let noteToDelete = notes[index]
        coreDataManager.delete(note: noteToDelete)
        fetchNotes()
    }
}

