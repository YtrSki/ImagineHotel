//
//  ConfirmCheckInViewController.swift
//  UCD
//
//  Created by YutaroSakai on 2021/01/23.
//

import UIKit

class ConfirmCheckInViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numOfDateLabel: UILabel!
    @IBOutlet weak var numOfPeopleLabel: UILabel!
    @IBOutlet weak var hotelPlanLabel: UILabel!
    
    @IBOutlet weak var processingView: UIView!
    
    @IBAction func noButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func yesButtonAction(_ sender: Any) {
        processingView.isHidden = false
        Timer.scheduledTimer(timeInterval: 3.0,
                                   target: self,
                                   selector: #selector(self.runDismiss),
                                 userInfo: nil,
                                  repeats: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        processingView.isHidden = true
        
        userNameLabel.text = userName
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy年 MM月 dd日"
        dateLabel.text = dateFormat.string(from: bookingList[0].date)
        
        numOfDateLabel.text = bookingList[0].numOfDay.description + "泊"
        
        numOfPeopleLabel.text = bookingList[0].numOfPeople.description + "名"
        
        hotelPlanLabel.text = hotelPlanList[selectedHotelPlanNum]
    }
    
    @objc func runDismiss() -> Void {
        isStayingInHotel = true
        let rootVC = self.presentingViewController as! UITabBarController // 下のextensionに書かれた関数を呼び出す
        dismiss(animated: true, completion: {
            rootVC.presentStayingScreen()
        })
    }
}

extension UITabBarController {
    func presentStayingScreen() -> Void {
        if isStayingInHotel {
            self.selectedIndex = 0
            let topStayingScreenVC = UIStoryboard(name: "StayingScreen", bundle: nil).instantiateViewController(withIdentifier: "topStayingScreenViewController")
            topStayingScreenVC.modalTransitionStyle = .flipHorizontal
            topStayingScreenVC.modalPresentationStyle = .fullScreen
            self.present(topStayingScreenVC, animated: true, completion: nil)
        }
    }
}
