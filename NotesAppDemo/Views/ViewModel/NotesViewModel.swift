//
//  NotesViewModel.swift
//  NotesAppDemo
//
//  Created by Govind-BigOh on 16/12/24.
//

import Foundation

class NotesViewModel {
    private let coreDataManager: CoreDataManager
    var note: Note?
    
    var title: String {
        note?.title ?? ""
    }
    
    var body: String {
        note?.body ?? ""
    }
    
    var isNewNote: Bool {
        note == nil
    }
    
    // Bindable properties (can be used with reactive frameworks or manual bindings)
    var onNoteSaved: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(coreDataManager: CoreDataManager, note: Note? = nil) {
        self.coreDataManager = coreDataManager
        self.note = note
    }
    
    func saveNote(title: String, body: String) {
        if title.isEmpty || body.isEmpty {
            onError?("Title or body cannot be empty.")
            return
        }
        
        coreDataManager.saveNote(title: title, body: body, note: note)
        onNoteSaved?()
    }
}

