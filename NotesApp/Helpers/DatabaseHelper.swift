//
//  DatabaseHelper.swift
//  NotesApp
//
//  Created by Raj_iLS on 05/07/22.
//

import RealmSwift
import UIKit

class DatabaseHelper{
    
    static let shared = DatabaseHelper()
    /// Open the local-only default realm
    private var realm = try! Realm()
    
    func getDatabasePath() -> URL?{
        return Realm.Configuration.defaultConfiguration.fileURL
    }
    
    func saveContact(note: NotesModel){
        try! realm.write({
            realm.add(note)
        })
    }
    
    func updateContact(oldNote: NotesModel, newNote: NotesModel){
        try! realm.write{
            oldNote.title = newNote.title
            oldNote.note = newNote.note
        }
    }
    
    func deleteContact(note: NotesModel){
        try! realm.write{
            realm.delete(note)
        }
    }
    
    func getAllContacts() -> [NotesModel]{
        return Array(realm.objects(NotesModel.self))
    }
    
}
