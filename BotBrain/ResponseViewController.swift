//
//  ResponseViewController.swift
//  BotBrain
//
//  Created by Shivesh M M on 24/03/19.
//  Copyright © 2019 DOTsens. All rights reserved.
//

import UIKit

class ResponseViewController: UIViewController {
    var listID: Int!
    let url: String = "https://pdp-server-2019.herokuapp.com/botNav?list="
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var statusCodeLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        continueButton.layer.cornerRadius = continueButton.frame.size.height/2.0
        stopButton.layer.cornerRadius = stopButton.frame.size.height/2.0
        LoaderController.sharedInstance.showLoader()
        
        Just.get(url + String(listID)){ (r) in
            self.handler(r: r)
        }
        
    }
    @IBAction func stopNavButton(_ sender: Any) {
        let stop: String = "https://pdp-server-2019.herokuapp.com/endSession"
        LoaderController.sharedInstance.showLoader()
        Just.get(stop) {
            (r) in
            self.haltHandler(r: r)
        }
        
    }
    
    @IBAction func contNavButton(_ sender: Any) {
        let stop: String = "https://pdp-server-2019.herokuapp.com/appCont"
        LoaderController.sharedInstance.showLoader()
        Just.get(stop) {
            (r) in
            self.haltHandler(r: r)
        }
    }
    func haltHandler(r: HTTPResult) {
        DispatchQueue.main.async {
            if r.ok {
                self.statusCodeLabel.textColor = .green
                self.statusCodeLabel.text = "OK"
                let responseText = r.text?.replacingOccurrences(of: "\"", with: "")
                self.responseLabel.text = responseText
            }
            else {
                self.statusCodeLabel.textColor = .red
                self.statusCodeLabel.text = "Error " + String(r.statusCode!)
            }
            
        }
        LoaderController.sharedInstance.removeLoader()
    }
    func handler(r: HTTPResult) {
        DispatchQueue.main.async {
            if r.ok {
                self.statusCodeLabel.textColor = .green
                self.statusCodeLabel.text = "OK"
                let responseText = r.text?.replacingOccurrences(of: "\"", with: "")
                self.responseLabel.text = responseText
            }
            else {
                self.statusCodeLabel.textColor = .red
                self.statusCodeLabel.text = "Error " + String(r.statusCode!)
            }
            
        }
        LoaderController.sharedInstance.removeLoader()
    }
    func stopHandler(r: HTTPResult) {
        
        DispatchQueue.main.async {
            if r.ok {
                self.statusCodeLabel.textColor = .green
                self.statusCodeLabel.text = "OK"
                self.responseLabel.text = "Navigation stopped"
            }
            else {
                self.statusCodeLabel.textColor = .red
                self.statusCodeLabel.text = "Error " + String(r.statusCode!)
            }
        }
        LoaderController.sharedInstance.removeLoader()
        
    }
    
}
