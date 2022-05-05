//
//  TodoTableViewCell.swift
//  SomeSwiftThingsTodo
//
//  Created by Nazif Enes Kızılcin on 5.05.2022.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
