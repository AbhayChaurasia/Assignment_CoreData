//
//  CoreDataTableViewCell.swift
//  Assignment
//
//  Created by Prince on 03/05/25.
//

import UIKit

class CoreDataTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var dataLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
