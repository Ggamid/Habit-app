//
//  TableViewCell.swift
//  Habbit app
//
//  Created by Gamıd Khalıdov on 22.08.2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var strickLabel: UILabel!
    @IBOutlet var checkmarkImage: UIImageView!
    @IBOutlet var subView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let radius: CGFloat = 10
        subView.layer.cornerRadius = radius
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
