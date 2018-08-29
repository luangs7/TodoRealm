//
//  ContactTableViewCell.swift
//  TodoRealm
//
//  Created by Retina on 8/29/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var descpt: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var content: UIView!
    
    var contact:Contact?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        content.applyDefaultShadow()
    }
    
    override func layoutSubviews() {
        profileImage.clipsToBounds = true
        profileImage.round()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func setupItem(contact:Contact){
        self.contact = contact
        name.text = contact.name
        descpt.text = contact.desc
//        profileImage
    }
}
