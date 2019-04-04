//
//  ProfileTableViewController.swift
//  BotBrain
//
//  Created by Shivesh M M on 01/03/19.
//  Copyright © 2019 DOTsens. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    
    let sectionTitles = ["Profile", "Settings", "About"]
    let numRows = [1,3,2]
    
    var userName = "John Doe"
    
    var settingsList = ["Funds", "Redeem Points", "My Lists"]
    let imageNames = ["wallet", "money_box", "list"]
    
    let versionBuild = ["Version", "Build"]
    let versionBuildVals = [
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String, Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numRows.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numRows[section]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0 {
           return 72.0
        }
        else {
            return tableView.rowHeight
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Section: \(indexPath.section) Row: \(indexPath.row)")
        if (indexPath.section == 0 && indexPath.row == 0) {
            showAlert()
            tableView.deselectRow(at: indexPath, animated: true)
        }
        else if(indexPath.section == 1 && indexPath.row == 0) {
            self.performSegue(withIdentifier: "FundsSegue", sender: self)
        }
        else if(indexPath.section == 1 && indexPath.row == 1) {
            self.performSegue(withIdentifier: "RedeemPointsSegue", sender: self)
        }
        else if(indexPath.section == 1 && indexPath.row == 2) {
            self.performSegue(withIdentifier: "MyListsSegue", sender: self)
        }
    }
    func showAlert() {
        let alert = UIAlertController.init(title: "Logout", message: "Do you want to logout?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: nil))   //TODO : ADD THE HANDLER
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.imageView?.image = UIImage(named: "user_male")
            cell.textLabel?.text = userName
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
            cell.accessoryType = .disclosureIndicator
            cell.imageView?.image = UIImage(named: imageNames[indexPath.row])
            cell.textLabel?.text = settingsList[indexPath.row]
            return cell
        default:
            let vcell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "versioningCell")
            let currentKey = String(versionBuild[indexPath.row])
            let currentValue: String
            if currentKey=="Build" {
                currentValue = versionBuildVals[indexPath.row]
            }
            else {
                currentValue = versionBuildVals[indexPath.row]
            }
            vcell.selectionStyle = .none
            vcell.textLabel?.text = currentKey
            vcell.detailTextLabel?.text = currentValue
            return vcell
        }
    }
}
