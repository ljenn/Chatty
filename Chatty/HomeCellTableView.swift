//
//  HomeCellTableView.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/15/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit

class HomeCellTableView: UITableViewCell {
    
    //each cell displays a profile on the home page (table of profiles) 
    
    @IBOutlet weak var imgHomeCell: UIImageView!
    
    @IBOutlet weak var firstNHomeCell: UILabel!
    
    @IBOutlet weak var statusHomeCell: UILabel!
    
    @IBOutlet weak var storyHomeCell: UILabel!
    
    @IBOutlet weak var emoji: UIImageView!
    
    @IBOutlet weak var moodLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
