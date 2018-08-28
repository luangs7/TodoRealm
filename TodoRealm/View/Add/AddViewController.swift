//
//  AddViewController.swift
//  TodoRealm
//
//  Created by Retina on 8/28/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit

class AddViewController: BaseViewController {

    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var titleTextView: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Adicionar"
    }

   
    @IBAction func onSubmit(_ sender: UIButton) {
        sender.activityStart()
        
        
        if let item = createItem(){
            DBManager.sharedInstance.addData(object: item)
            dismissViewController()
        }
        
    }
    
    private func createItem() -> Item?{
        guard let title = titleTextView.text, title.length > 0 else{
            alert(withMessage: "Não pode ficar em branco!")
            return nil
        }
        
        let item = Item()
        item.id = Int(arc4random())
        item.title = title
        return item
    }
    
}
