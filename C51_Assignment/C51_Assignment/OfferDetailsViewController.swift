//
//  OfferDetailsViewController.swift
//  C51_Assignment
//
//  Created by iOSDev on 2022-05-12.
//

import Foundation
import UIKit

class OfferDetailsViewController: UIViewController {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemIdLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var itemImage: UIImage = UIImage()
    var itemName: String = ""
    var itemId: String = ""
    var offer: Offer = Offer()
    
    class func instantiate(image: UIImage, name: String, id: String, offer: Offer) -> OfferDetailsViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OfferDetailsViewController") as! OfferDetailsViewController
        
        vc.itemName = name
        vc.itemImage = image
        vc.itemId = id
        vc.offer = offer
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemImageView.image = self.itemImage
        self.itemNameLabel.text = self.itemName
        self.itemIdLabel.text = self.itemId
        self.backButton.layer.cornerRadius = self.backButton.frame.height/2
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
