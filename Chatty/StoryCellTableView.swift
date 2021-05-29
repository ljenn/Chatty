//
//  StoryCellTableView.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 5/18/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit

class StoryCellTableView: UITableViewCell {
    
    //NO NEED: CHECK!! DON'T BE CONFUSED!!!!!
    
    @IBOutlet weak var SingleStoryContext: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
