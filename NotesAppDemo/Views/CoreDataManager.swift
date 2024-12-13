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
    
    func saveNote(title: String, body: String) {
        let note = Note(context: persistentContainer.viewContext)
        note.title = title
        note.body = body
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Error saving note: \(error)")
        }
    }
    
//    func fetchAllNotes() {
//        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
//        do {
//            let notes = try persistentContainer.viewContext.fetch(fetchRequest)
//            for note in notes {
//                print("Title: \(note.title!), Body: \(note.body!)")
//            }
//        } catch {
//            print("Error fetching notes: \(error)")
//        }
//    }
}
