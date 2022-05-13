//
//  OfferDetailsViewController.swift
//  C51_Assignment
//
//  Created by iOSDev on 2022-05-12.
//  Zachary Seguin

import Foundation
import UIKit

class OfferDetailsViewController: UIViewController {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemIdLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var itemImage: UIImage = UIImage()
    var offer: Offer = Offer()
    
    class func instantiate(image: UIImage, offer: Offer) -> OfferDetailsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OfferDetailsViewController") as! OfferDetailsViewController
        
        vc.itemImage = image
        vc.offer = offer
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Update UI with offer data after instantiation
        self.itemImageView.image = self.itemImage
        self.itemNameLabel.text = self.offer.name
        self.itemIdLabel.text = self.offer.id
        self.backButton.layer.cornerRadius = self.backButton.frame.height/2 // Make back button round
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        // Return to intial view controller
        self.dismiss(animated: true)
    }
    
}
