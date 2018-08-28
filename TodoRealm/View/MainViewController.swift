//
//  MainViewController.swift
//  TodoRealm
//
//  Created by Retina on 8/28/18.
//  Copyright © 2018 Retina. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ToDo"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
    }

    @IBAction func toAdd(_ sender: UIButton) {
        pushViewController(viewController: AddViewController(nibName: "AddViewController", bundle: nil))
    }
    
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.allowsSelection = false
        
        
        tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoTableViewCell")
        
        tableView.reloadData()
     
    }


}

extension MainViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DBManager.sharedInstance.getDataFromDB().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath as IndexPath) as! TodoTableViewCell
        cell.delegate = self
        cell.setupItem(item: DBManager.sharedInstance.getDataFromDB()[indexPath.row])
        
        return cell
        
    }
    
    
}

extension MainViewController:TodoCellDelegate{
    func onItemDelete() {
        tableView.reloadData()
    }
}
