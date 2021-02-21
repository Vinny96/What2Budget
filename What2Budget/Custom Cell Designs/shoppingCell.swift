//
//  shoppingCell.swift
//  What2Budget
//
//  Created by Vinojen Gengatharan on 2021-01-31.
//

import UIKit

class shoppingCell: UITableViewCell {

    // IB Outlets
    @IBOutlet weak var retailer: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = cellView.frame.size.height / 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
