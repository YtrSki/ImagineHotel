//
//  PurchasedListViewController.swift
//  UCD
//
//  Created by YutaroSakai on 2021/01/24.
//

import UIKit

class PurchasedListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var quantityOfPurchasedLabel: UILabel!
    @IBOutlet weak var sumOfValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quantityOfPurchasedLabel.text = purchasedList.count.description + " 点"
        
        var sum = 0
        for v in purchasedList {
            sum += v.value
        }
        sumOfValueLabel.text = "¥ " + sum.description
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchasedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = purchasedList[indexPath.row].name
        cell.detailTextLabel?.text = "¥ " + purchasedList[indexPath.row].value.description
        return cell
    }
}
