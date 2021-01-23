//
//  OrderConfirmViewController.swift
//  UCD
//
//  Created by YutaroSakai on 2021/01/23.
//

import UIKit

class OrderConfirmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var orderList: [Yakitori] = [] // 前の注文画面から注文リストが渡される
    
    @IBOutlet weak var sumOfQuantityLabel: UILabel!
    @IBOutlet weak var sumOfValueLabel: UILabel!
    
    @IBOutlet weak var processingView: UIView!
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sendOrderButtonAction(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "ご注文を確定して送信してもよろしいですか？", message: "確定されたご注文は取り消しできません。", preferredStyle:  UIAlertController.Style.actionSheet)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.default, handler:{_ in
            // 注文を確定した時の処理
            self.isModalInPresentation = true // 下スライドで閉じないように
            self.processingView.isHidden = false // 処理中画面を表示
            Timer.scheduledTimer(timeInterval: 3.0,
                                       target: self,
                                     selector: #selector(self.runDismiss),
                                     userInfo: nil,
                                      repeats: false)
            })
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processingView.isHidden = true
        
        sumOfQuantityLabel.text = orderList.count.description + " 点"
        
        var sumOfValue = 0
        for v in orderList {
            sumOfValue += v.value
        }
        sumOfValueLabel.text = "¥ " + sumOfValue.description
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = orderList[indexPath.row].name
        cell.detailTextLabel?.text = "¥ " + orderList[indexPath.row].value.description
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func runDismiss() -> Void {
        purchasedList += self.orderList // 購入済みリストに確定した注文を追加
        
        processingView.isHidden = true
        let alert: UIAlertController = UIAlertController(title: "ご注文を送信しました！", message: "準備ができ次第スタッフがお部屋まで非接触でお持ちします。\n混雑状況によっては時間がかかる場合がございます。\nしばらくお待ちください。", preferredStyle:  UIAlertController.Style.alert)
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler:{_ in
            self.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
}
