//
//  CoreDataManager.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 12/12/24.
//

import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func saveNote(title: String, body: String, note: Note? = nil) {
        let context = persistentContainer.viewContext
        
        if let noteToUpdate = note {
            noteToUpdate.title = title
            noteToUpdate.body = body
        } else {
            let newNote = Note(context: context)
            newNote.title = title
            newNote.body = body
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save note: \(error)")
        }
    }

    func delete(note: Note) {
        let context = persistentContainer.viewContext
        context.delete(note)

        do {
            try context.save()
        } catch {
            print("Failed to delete note: \(error)")
        }
    }
}
