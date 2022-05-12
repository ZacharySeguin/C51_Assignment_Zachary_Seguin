//
//  Offer.swift
//  C51_Assignment
//
//  Created by iOSDev on 2022-05-12.
//

import Foundation

class Offer {
    
    var name: String
    var id: String
    var imageUrl: String
    var cashbackValue: String

    init(name: String, id: String, imageUrl: String, cashbackValue: Float) {
        self.name = name
        self.id = id
        self.imageUrl = imageUrl
        self.cashbackValue = String(format: "%.1f", cashbackValue)
    }
    
    init(){
        self.name = ""
        self.id = ""
        self.imageUrl = ""
        self.cashbackValue = ""
    }
    
    func printOfferDescription(){
        print("\n~~~~~~~~~~~~~\n" +
              "Offer ID: \(self.id)\n" +
              "Name: \(self.name)\n" +
              "Image URL: \(self.imageUrl)\n" +
              "Cashback: \(self.cashbackValue)")
    }
    
}
