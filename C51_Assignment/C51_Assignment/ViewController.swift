//
//  ViewController.swift
//  C51_Assignment
//
//  Created by iOSDev on 2022-05-11.
//  Zachary Seguin

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var offerTableView: UITableView!
    @IBOutlet weak var sortByNameButton: UIButton!
    @IBOutlet weak var sortByCashbackButton: UIButton!
    
    var offerList = [Offer]() // Stores an original copy of the JSON offer list
    var sortedList = [Offer]() // Is a copy of offerList which can be sorted and displayed on UITableView
    
    var sortingByCashback: Bool = false
    var sortingByName: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.offerTableView.delegate = self
        self.offerTableView.dataSource = self
        
        self.sortByNameButton.backgroundColor = UIColor.black
        self.sortByCashbackButton.backgroundColor = UIColor.black
        
        getOffersFromJSON()
    }
    
    func getOffersFromJSON(){
        // Read file and parse JSON data into offer instances for offerList
        let data = readLocalFile(forName: "c51")
        if(data == nil){ return }
        print("Parsing JSON data...")
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                // Try to read array of dictionaries
                if let offers = json["offers"] as? [Dictionary<String,Any>] {
                    //For each offer, assign values from keys to variables to construct Offer obj
                    for offer in offers {
                        if let id = offer["offer_id"] as? String {
                            if let name = offer["name"] as? String {
                                if let imageUrl = offer["image_url"] as? String {
                                    if let cashback = offer["cash_back"] as? Float {
                                        //Create instance of Offer obj to populate tableView
                                        let newOffer = Offer(name: name, id: id, imageUrl: imageUrl, cashbackValue: cashback)
                                        newOffer.printOfferDescription()
                                        self.offerList.append(newOffer)
                                    }
                                }
                            }
                        }
                    }
                    
                }
                print("Finished parsing JSON data!")
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        
        if(self.offerList.count != 0){ // If offer objects were created, reload table and generate cells
            self.offerTableView.isHidden = false
            self.sortedList = self.offerList
            self.offerTableView.reloadData()
        }else{
            self.offerTableView.isHidden = true // Hide table if it has no content to display no content UI
        }
        
    }
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            // Attempt to find file and read data
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("Read local file: \(error)")
        }
        
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OfferTableViewCell = self.offerTableView.dequeueReusableCell(withIdentifier: "OfferTableViewCell") as! OfferTableViewCell
        
        // Configure cell with data from offer at indexPath
        cell.configure(offer: self.sortedList[indexPath.row], cellId: indexPath.row);
        
        return cell
    }

    @IBAction func cellSelectedButtonAction(_ sender: UIButton) {
        // Present OfferDetailsViewController initialized with data from selected cell (not necessary for assignment)
        print("User tapped on cell with ID: \(sender.tag)")
        let selectedCell = self.offerTableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! OfferTableViewCell
        let vc = OfferDetailsViewController.instantiate(image: selectedCell.offerImageView.image ?? UIImage(), offer: self.sortedList[sender.tag])
        self.present(vc, animated: true)
        
    }
    
    @IBAction func sortByNameButtonAction(_ sender: UIButton) {
        
        if(self.sortingByCashback == true){ // Check if sorting is already active with cashback button
            self.sortingByCashback = false // Set cashback button to default UI and reset list to be sorted by name
            self.sortByCashbackButton.backgroundColor = .black
            self.sortedList = self.offerList
        }
        
        self.sortingByName = true
        
        if(sender.tag == 0){ // First time tapping button
            self.sortedList.sort(by: { $0.name > $1.name })
            self.sortByNameButton.tag = 1
            self.sortByNameButton.backgroundColor = .darkGray
        } else if(sender.tag == 1) { // Second time tapping button
            self.sortedList.sort(by: { $0.name < $1.name })
            self.sortByNameButton.tag = 2
            self.sortByNameButton.backgroundColor = .lightGray
        } else { // Reset list to original order
            self.sortedList = self.offerList
            self.sortByNameButton.tag = 0
            self.sortByNameButton.backgroundColor = .black
        }
        
        self.offerTableView.reloadData()
    }
    
    @IBAction func sortByCashbackButtonAction(_ sender: UIButton) {
        
        if(sortingByName == true){ // Check if sorting is already active with name button
            self.sortingByName = false // Set name button to default UI and reset list to be sorted by cashback
            self.sortByNameButton.backgroundColor = .black
            self.sortedList = self.offerList
        }
        
        self.sortingByCashback = true
        
        if(sender.tag == 0){ // First time tapping button
            self.sortedList.sort(by: { $0.cashbackValue > $1.cashbackValue })
            self.sortByCashbackButton.tag = 1
            self.sortByCashbackButton.backgroundColor = .darkGray
        } else if(sender.tag == 1) { // Second time tapping button
            self.sortedList.sort(by: { $0.cashbackValue < $1.cashbackValue })
            self.sortByCashbackButton.tag = 2
            self.sortByCashbackButton.backgroundColor = .lightGray
        } else { // Reset list to original order
            self.sortedList = self.offerList
            self.sortByCashbackButton.tag = 0
            self.sortByCashbackButton.backgroundColor = .black
        }
        
        self.offerTableView.reloadData()
    }
    
}

