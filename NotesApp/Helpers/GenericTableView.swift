//
//  GenericTableView.swift
//  NotesApp
//
//  Created by Raj_iLS on 05/07/22.
//

import Foundation
import UIKit

class GenericTableView<T: UITableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    static var title: String { return "Table View" }
    var isContextMenu = Bool()

    var didSelect: (T, Int) -> Void = { _, _ in }
    let screenSize: CGRect = UIScreen.main.bounds
    var didScroll: () -> Void = { }
    var configure : ((T, Int) -> Void)?
    var identifier = String()
    var nib = UINib()
    var isScrolled = Bool()
    var array: [Any] = []
    var emptyMessage = String()

    func registerCells(forTableView tableView: UITableView) {
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
         
         return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
             // Create an action for editing
             let edit = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil")) { action in
                 // Perform renaming
                 guard let viewController = UIViewController.topMostViewController() else { return }
                 let composeNotesVC = viewController.storyboard!.instantiateViewController(withIdentifier: "ComposeNotesVC") as! ComposeNotesVC
                 composeNotesVC.modalPresentationStyle = .fullScreen
                 composeNotesVC.notesModel = self.array[indexPath.row] as? NotesModel
                 viewController.present(composeNotesVC, animated: true, completion: nil)

             }
             // Here we specify the "destructive" attribute to show that it’s destructive in nature
             let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                 // Perform delete
                 DatabaseHelper.shared.deleteContact(note: self.array[indexPath.row] as! NotesModel)
                 NotificationCenter.default.post(name: Notification.Name("deleteNote"), object: nil)
             }
             if self.isContextMenu {
                 return UIMenu(title: "", children: [edit, delete])
             }else {
                 return nil
             }
         }
     }
    func loadCell(atIndexPath indexPath: IndexPath, forTableView tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        configure?(cell as! T, indexPath.row)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if array.count == 0 {
            tableView.setEmptyMessage(emptyMessage, table: tableView)
         }else {
             tableView.restore()
         }
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.loadCell(atIndexPath: indexPath, forTableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        didSelect(cell as! T, indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height && !isScrolled {
            didScroll()
            isScrolled = true
        }
    }
}
// MARK:- Empty Message with Image
extension UITableView {

    func setEmptyMessage(_ message: String, table: UITableView) {
        
       let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .boldSystemFont(ofSize: 16)
     //   messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
extension UITableView {
    var contentSizeHeight: CGFloat {
        var height = CGFloat(0)
        for section in 0..<numberOfSections {
            height = height + rectForHeader(inSection: section).height
            let rows = numberOfRows(inSection: section)
            for row in 0..<rows {
                height = height + rectForRow(at: IndexPath(row: row, section: section)).height
            }
        }
        return height
    }
}

