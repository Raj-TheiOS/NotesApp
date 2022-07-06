//
//  NotesModel.swift
//  NotesApp
//
//  Created by Raj_iLS on 05/07/22.
//

import Foundation
import UIKit
import RealmSwift

class NotesModel: Object{
    @Persisted var title: String = ""
    @Persisted var note: String = ""
    
    convenience init(title: String, note: String){
        self.init()
        self.title = title
        self.note = note
    }
}
