//
//  postCell.swift
//  SwiftStagram
//
//  Created by 林祐辰 on 2020/8/17.
//

import UIKit

class postCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postPhoto: UIImageView!
    @IBOutlet weak var likeText: UILabel!
    @IBOutlet weak var paragraphText: UILabel!
    @IBOutlet weak var postDateText: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
