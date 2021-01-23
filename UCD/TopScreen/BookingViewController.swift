//
//  BookingViewController.swift
//  UCD
//
//  Created by YutaroSakai on 2021/01/22.
//

import UIKit

class BookingViewConroller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bookingListTable: UITableView!
    @IBOutlet weak var noBookingLabel: UILabel!
    @IBOutlet weak var bookingButton: UIButton!
    @IBAction func bookingButtonAction(_ sender: Any) {
        let setBookingViewController = UIStoryboard(name: "SetBookingViewController", bundle: nil).instantiateViewController(withIdentifier: "setBookingViewController")
        setBookingViewController.presentationController?.delegate = self
        self.present(setBookingViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookingListTable.delegate = self
        bookingListTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookingList.count > 0 {
            noBookingLabel.isHidden = true
        }
        else {
            noBookingLabel.isHidden = false
        }
        
        return bookingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()

        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
        cell.textLabel?.text = bookingList[indexPath.row].hotelName
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy/MM/dd"
        cell.detailTextLabel?.text = dateFormat.string(from: bookingList[indexPath.row].date)

        return cell
    }
}
    
// .pageSheetのモーダルをdismissした後にこの画面のテーブルビューを更新する処理を発動させるためのextension
extension BookingViewConroller: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.bookingListTable.reloadData()
    }
}
