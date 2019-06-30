//
//  NonUserMessageCell.swift
//  FireChat
//
//  Created by Daniel Barclay on 30/06/2019.
//  Copyright © 2019 Daniel Barclay. All rights reserved.
//

import UIKit

class NonUserMessageCell: UITableViewCell {

    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var sender: UILabel!
    @IBOutlet weak var message: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
