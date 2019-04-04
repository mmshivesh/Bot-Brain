//
//  ImportListViewController.swift
//  BotBrain
//
//  Created by Shivesh M M on 24/03/19.
//  Copyright © 2019 DOTsens. All rights reserved.
//

import UIKit

class ImportListTableViewController: UITableViewController {
    var noOfLists: Int = 0
    var currentCell: Int = 0
    var toSend: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Show the loading indicator while loading data from server
        LoaderController.sharedInstance.showLoader()
        Just.get("https://pdp-server-2019.herokuapp.com/lists")
        {
            (r) in
            self.handle(r:r)
        }
    }
    func handle(r:HTTPResult){
        if let dictionary = r.json! as? [String: Any] {
            self.noOfLists = (dictionary["no_of_lists"] as? Int)!
        }
        // Once table data is ready, refresh the table view
        DispatchQueue.main.async
        {
            self.tableView.reloadData()
        }
        // Remove the loading indicator
        LoaderController.sharedInstance.removeLoader()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "showListSegue", sender: indexPath)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noOfLists
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let string: String = "List "
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for:indexPath)
        if(self.currentCell<self.noOfLists) {
            cell.textLabel?.text = string + String(self.currentCell)
            self.currentCell+=1
        }
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showListSegue" {
            let row = (sender as! NSIndexPath).row
            let nextVC = segue.destination as! showListItemTableViewController
            nextVC.listID = row
        }
    }
}
