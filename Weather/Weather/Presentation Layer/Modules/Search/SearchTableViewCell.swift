//
//  searchTableViewCell.swift
//  Weather
//
//  Created by Eddy R on 29/09/2020.
//  Copyright © 2020 Eddy R. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    static var xibName: String = "SearchTableViewCell"
  
    
    
  @IBOutlet weak var nameCity: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
