//
//  showListItemViewController.swift
//  BotBrain
//
//  Created by Shivesh M M on 24/03/19.
//  Copyright © 2019 DOTsens. All rights reserved.
//

import UIKit

class showListItemTableViewController: UITableViewController {
    var listID: Int!
    var noOfItems: Int = 0
    var currentCell: Int = 0
    var items: [String] = []
    let url: String = "https://pdp-server-2019.herokuapp.com/lists?id="
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navBar.title = "List " + String(self.listID)
        LoaderController.sharedInstance.showLoader()
        Just.get(url + String(listID)) {
            (r) in
            self.handler(r: r)
        }
    }
    func handler(r: HTTPResult) {
        if let dictionary = r.json! as? [String: Any] {
            items = (dictionary["items"] as? [String])!
            self.noOfItems = items.count
            
        }
        // Once table data is ready, refresh the table view
        DispatchQueue.main.async
        {
                self.tableView.reloadData()
        }
        // Remove the loading indicator
        LoaderController.sharedInstance.removeLoader()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noOfItems
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell", for:indexPath)
            cell.textLabel?.text = items[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    @IBAction func startButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "statusSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "statusSegue" {
            let nextVC = segue.destination as! ResponseViewController
            nextVC.listID = listID
        }
    }
}
