//
//  MessageTableViewCell.swift
//  ChatWithParse
//
//  Created by Chihiro Saito on 10/26/16.
//  Copyright © 2016 Chihiro Saito. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
