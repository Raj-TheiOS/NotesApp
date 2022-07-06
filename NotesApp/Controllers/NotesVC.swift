//
//  ViewController.swift
//  NotesApp
//
//  Created by Raj_iLS on 05/07/22.
//

import UIKit

class NotesVC: UIViewController {
    
    @IBOutlet weak var notesTable: UITableView!
    
    var datasourceTable = GenericTableView()
    var notesArray = [NotesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteNoteReceivedNotification(notification:)), name: Notification.Name("deleteNote"), object: nil)

    }
    @objc func deleteNoteReceivedNotification(notification: Notification) {
        self.viewWillAppear(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        notesArray = DatabaseHelper.shared.getAllContacts()
        self.setUpTableCell(notes: notesArray)
        self.notesTable.reloadData()
    }
    
    // MARK:- loading data in cell
    func setUpTableCell(notes: [NotesModel]) {
        datasourceTable.isContextMenu = true
        datasourceTable.emptyMessage = "Notes not available!"
        datasourceTable.array = notes
        datasourceTable.identifier = NotesCell.identifier
        notesTable.dataSource = datasourceTable
        notesTable.delegate = datasourceTable
        notesTable.tableFooterView = UIView()
        datasourceTable.configure = {cell, index in
            guard let notesCell = cell as? NotesCell else { return }
            notesCell.object = notes[index]
        }
        datasourceTable.didScroll = {
        }
        datasourceTable.didSelect = {cell, index in
            self.showAlert(withTitle: "Suggestion", andMessage: "Use long press for edit and delete menu options")
        }
    }
    
    @IBAction func didtapCompose(_ sender: Any) {
        let composeNotesVC = self.storyboard!.instantiateViewController(withIdentifier: "ComposeNotesVC")
        composeNotesVC.modalPresentationStyle = .fullScreen
        self.present(composeNotesVC, animated: true, completion: nil)
    }
    

}

