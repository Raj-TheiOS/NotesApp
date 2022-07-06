//
//  NotesCell.swift
//  NotesApp
//
//  Created by Raj_iLS on 05/07/22.
//

import UIKit

class NotesCell: UITableViewCell, ReusableCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descributionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK:- Loading data to table cell
    var object: NotesModel? {
        didSet {
            self.titleLabel.text = object?.title ?? ""
            self.descributionLabel.text = object?.note ?? ""
        }
    }
}
