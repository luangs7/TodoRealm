//
//  ContactsViewController.swift
//  TodoRealm
//
//  Created by Retina on 8/29/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit

class ContactsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        setupTableView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        let contact = Contact()
//        contact.id = Int(arc4random())
//        contact.name = "Fulano " + String(arc4random())
//        contact.desc = "Analista de Sistemas"
        
//        RealmManager.sharedInstance.addContact(object: contact)
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = 125
        
        
        tableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
        
        tableView.reloadData()
        
        
    }
  
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmManager.sharedInstance.getContacts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath as IndexPath) as! ContactTableViewCell
        
        cell.setupItem(contact: RealmManager.sharedInstance.getContacts()[indexPath.row])
        
        return cell

    }
    
}
