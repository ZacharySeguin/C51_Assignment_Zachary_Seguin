//
//  OfferTableViewCell.swift
//  C51_Assignment
//
//  Created by iOSDev on 2022-05-12.
//  Zachary Seguin

import Foundation
import UIKit

class OfferTableViewCell: UITableViewCell {
    
    @IBOutlet weak var offerNameLabel: UILabel!
    @IBOutlet weak var offerIdLabel: UILabel!
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerImageLoadingView: UIView!
    @IBOutlet weak var cashbackValueLabel: UILabel!
    @IBOutlet weak var cellSelectionButton: UIButton!
    
    var uniqueId: Int = 0
    var imageUrl: String = ""
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(offer: Offer, cellId: Int) {
        //Configure cell with information
        self.offerNameLabel.text = offer.name
        self.offerIdLabel.text = offer.id
        self.imageUrl = offer.imageUrl
        self.cashbackValueLabel.text = offer.cashbackValue
        self.uniqueId = cellId
        self.cellSelectionButton.tag = cellId
        self.offerImageLoadingView.isHidden = false
        
        if let url: URL = URL(string: self.imageUrl) {
            self.downloadImage(from: url)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        // URL session to get data with completion handler and escaping vars
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        // Download image from url, handle UI updates and errors
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                self.offerImageLoadingView.isHidden = true
                return
            }
            
            DispatchQueue.main.async() {
                self.offerImageLoadingView.isHidden = true
                self.offerImageView.image = UIImage(data: data)
            }
        }
    }
}


