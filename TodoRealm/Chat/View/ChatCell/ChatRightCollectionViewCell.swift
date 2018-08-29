//
//  ChatRightCollectionViewCell.swift
//  TodoRealm
//
//  Created by Retina on 8/29/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit

class ChatRightCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var content: UIView!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var conversation:Conversa?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        content.applyDefaultShadow()
    }
    
    override func layoutSubviews() {
        profileImage.clipsToBounds = true
        profileImage.round()
    }
    
    
    func setupItem(conversation:Conversa){
        text.text = conversation.message
    }
    

}
