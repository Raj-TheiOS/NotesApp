//
//  ComposeNotesVC.swift
//  NotesApp
//
//  Created by Raj_iLS on 05/07/22.
//

import UIKit

class ComposeNotesVC: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextView!
    
    var notesArray = [NotesModel]()
    var notesModel: NotesModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.titleTF.text = notesModel?.title ?? ""
        self.descriptionTF.text = notesModel?.note ?? ""
    }
    
    @IBAction func didtapBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didtapSave(_ sender: Any) {
        if isValid() {
            self.saveData()
        }
    }
    
    // MARK:- save data to realm
    func saveData() {
        let notes = NotesModel(title: titleTF.text ?? "", note: descriptionTF.text ?? "")
        self.notesArray.append(notes)
        DatabaseHelper.shared.saveContact(note: notes)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:- Validating input fields
    func isValid() -> Bool {
        if titleTF.text?.isEmpty ?? false {
            self.showAlert(withTitle: "Empty Title!", andMessage: "Please enter title")
            return false
        }
        if descriptionTF.text?.isEmpty ?? false {
            self.showAlert(withTitle: "Empty Description!", andMessage: "Please enter description")
            return false
        }
        return true
    }
    
    
}
