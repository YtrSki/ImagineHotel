//
//  SetBookingViewController.swift
//  UCD
//
//  Created by YutaroSakai on 2021/01/22.
//

import UIKit

class SetBookingViewController: UIViewController {
    
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var numOfDayLabel: UILabel!
    @IBOutlet weak var numOfPeopleLabel: UILabel!
    @IBOutlet weak var numOfDayStepper: UIStepper!
    @IBOutlet weak var numOfPeopleStepper: UIStepper!
    
    @IBAction func numOfDayStepperAction(_ sender: UIStepper) {
        numOfDayLabel.text = Int(sender.value).description
    }
    @IBAction func numOfPeopleStepperAction(_ sender: UIStepper) {
        numOfPeopleLabel.text = Int(sender.value).description
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy年 MM月 dd日"
        
        let alert: UIAlertController = UIAlertController(title: "以下の内容で予約を確定しますか？", message: "\nホテル\n\( hotelNameLabel.text!.description)\n\n宿泊日時\n\(dateFormat.string(from: datePicker.date))\n\n宿泊日数\n\( numOfDayLabel.text!.description)日\n\n利用者数\n\(numOfPeopleLabel.text!.description)名", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.default, handler:{
            (action: UIAlertAction!) -> Void in
            bookingList += [Booking(hotelName: self.hotelNameLabel.text!, date: self.datePicker.date, numOfDay: Int(self.numOfDayStepper.value), numOfPeople: Int(self.numOfPeopleStepper.value))]
            
            self.dismiss(animated: true, completion: nil)
            })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "この画面を閉じてもよろしいですか？", message: "入力された内容は保存及び予約されません。", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.default, handler:{_ in
                self.dismiss(animated: true, completion: nil)
            })
            // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true // 下スワイプで閉じないようにする
        
        hotelNameLabel.text = "ホテル トクトラス"
        
    }
}

// dismissした時に親元のViewControllerのpresentationControllerDidDismissを発動させるためのextension
extension SetBookingViewController {
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        guard let presentationController = presentationController else {
            return
        }
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}
