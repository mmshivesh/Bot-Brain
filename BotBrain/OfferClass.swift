//
//  OfferClass.swift
//  BotBrain
//
//  Created by Shivesh M M on 01/03/19.
//  Copyright © 2019 DOTsens. All rights reserved.
//

import Foundation

class Offer {
    var percent: Float
    var item: String
    var category: String
    
    init(percent: Float,item: String, category: String) {
        self.percent = percent
        self.item = item
        self.category = category
    }
    
    func Discount() -> String {
        let toReturn = String(percent) + "% off on " + item
        return toReturn
    }
    func Category() -> String {
        return self.category
    }
}
