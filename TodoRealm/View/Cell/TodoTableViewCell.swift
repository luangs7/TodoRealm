//
//  TodoTableViewCell.swift
//  TodoRealm
//
//  Created by Retina on 8/28/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit

protocol TodoCellDelegate {
    func onItemDelete()
}


class TodoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var option: UISwitch!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UIView!
    var item:Item?
    var delegate:TodoCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        content.applyDefaultShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupItem(item:Item){
        self.item = item
        option.isOn = item.isFinished
        title.text = item.title
        
        option.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)

    }
    
    @objc func switchValueDidChange(_ sender: UISwitch){
        if(sender.isOn){
            DBManager.sharedInstance.deleteFromDb(object: self.item!)
            delegate?.onItemDelete()
        }
        
    }
    
}
