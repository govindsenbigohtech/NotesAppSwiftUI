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
    
    func saveNote(title: String, body: String, note: Note?) {
           let context = persistentContainer.viewContext
           let noteToSave: Note
           
           if let existingNote = note {
               noteToSave = existingNote
           } else {
               noteToSave = Note(context: context)
           }
           
           noteToSave.title = title
           noteToSave.body = body
           noteToSave.timestamp = Date() 
           
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
