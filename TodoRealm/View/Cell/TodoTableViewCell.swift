//
//  TodoTableViewCell.swift
//  TodoRealm
//
//  Created by Retina on 8/28/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    
    var item:Item?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupItem(item:Item){
        self.item = item
    }
    
}
