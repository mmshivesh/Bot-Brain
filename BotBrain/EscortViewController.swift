//
//  EscortViewController.swift
//  BotBrain
//
//  Created by Shivesh M M on 01/03/19.
//  Copyright © 2019 DOTsens. All rights reserved.
//

import UIKit

class EscortViewController: UIViewController {


    @IBOutlet weak var importListButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        importListButton.layer.cornerRadius = importListButton.frame.size.height/2.0
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
