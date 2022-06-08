//
//  FeedCell.swift
//  fbook
//
//  Created by Yagiz Ozturk on 8.06.2022.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var postimagev: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
