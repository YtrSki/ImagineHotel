//
//  ConfirmCheckOutViewController.swift
//  UCD
//
//  Created by YutaroSakai on 2021/01/24.
//

import UIKit

class ConfirmCheckOutViewController: UIViewController {
    
    @IBOutlet weak var processingView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numOfDayLabel: UILabel!
    @IBOutlet weak var numOfPeopleLabel: UILabel!
    @IBOutlet weak var hotelPlanLabel: UILabel!
    
    @IBOutlet weak var planValueLabel: UILabel!
    @IBOutlet weak var foodValueLabel: UILabel!
    @IBOutlet weak var sunValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        processingView.isHidden = true
        
        userNameLabel.text = userName
        
        let format = DateFormatter()
        format.dateFormat = "yyyy年 MM月 dd日"
        dateLabel.text = format.string(from: bookingList[0].date)
        
        numOfDayLabel.text = bookingList[0].numOfDay.description + "泊"
        numOfPeopleLabel.text = bookingList[0].numOfPeople.description + "名"
        hotelPlanLabel.text = hotelPlanList[selectedHotelPlanNum]
        
        planValueLabel.text = "¥9800 × " + bookingList[0].numOfDay.description + "泊"
        
        var sumOfPurchased = 0
        for v in purchasedList {
            sumOfPurchased += v.value
        }
        foodValueLabel.text = "¥ " + sumOfPurchased.description
        
        sunValueLabel.text = "¥ " + (9800 * bookingList[0].numOfDay + sumOfPurchased).description
    }
    
    @IBAction func yesButtonAction(_ sender: Any) {
        processingView.isHidden = false
        Timer.scheduledTimer(timeInterval: 3.0,
                                   target: self,
                                 selector: #selector(self.runDismiss),
                                 userInfo: nil,
                                  repeats: false)
    }
    @IBAction func noButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func runDismiss() -> Void {
        self.processingView.isHidden = true
        
        let alert: UIAlertController = UIAlertController(title: "チェックアウトが完了しました", message: "ご利用ありがとうございました。\nまたのご利用をお待ちしております。", preferredStyle: .alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: {_ in 
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            isStayingInHotel = false
        })
        alert.addAction(defaultAction)
        self.present(alert, animated: true)
    }
}
