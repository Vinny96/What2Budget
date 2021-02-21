//
//  groceryCell.swift
//  What2Budget
//
//  Created by Vinojen Gengatharan on 2021-01-31.
//

import UIKit

class groceryCell: UITableViewCell {

    //IB Outlets
    @IBOutlet weak var grocerTitleLabel: UILabel!
    @IBOutlet weak var amountSpentLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
