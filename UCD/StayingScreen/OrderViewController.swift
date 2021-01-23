//
//  OrderViewController.swift
//  UCD
//
//  Created by YutaroSakai on 2021/01/23.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var orderList: [Yakitori] = []
    var selectedValue: Int = 0
    var sumOfValue: Int = 0
    
    @IBOutlet weak var foodTable: UITableView!
    @IBOutlet weak var selectedCellLabel: UILabel!
    @IBOutlet weak var selectedValueLabel: UILabel!
    @IBOutlet weak var selectedQuantityLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var sumOfQuantityLabel: UILabel!
    @IBOutlet weak var sumOfValueLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBAction func quantityStepperAction(_ sender: Any) {
        selectedQuantityLabel.text = "数量:" + Int(quantityStepper.value).description
        selectedValueLabel.text = "¥ " + (selectedValue * Int(quantityStepper.value)).description
    }
    @IBAction func addButtonAction(_ sender: Any) {
        // 注文リストに追加する
        for _ in 0 ..< Int(quantityStepper.value) {
            orderList += [Yakitori(name: selectedCellLabel.text!, value: selectedValue)]
        }
        
        // 注文点数を更新する
        sumOfQuantityLabel.text = orderList.count.description + " 点"
        
        // 合計価格を更新する
        sumOfValue = 0
        for v in orderList {
            sumOfValue += v.value
        }
        sumOfValueLabel.text = "¥ " + sumOfValue.description
        
        // 確認ボタンを有効化する
        confirmButton.isEnabled = true
        confirmButton.backgroundColor = .orange
        
        // 連打防止として追加ボタンを無効化する
        addButton.isEnabled = false
        addButton.backgroundColor = .gray
    }
    
    // 取り消しボタンで注文リストをリセットする
    @IBAction func undoItemAction(_ sender: Any) {
        orderList = []
        sumOfQuantityLabel.text = orderList.count.description + " 点"
        sumOfValue = 0
        sumOfValueLabel.text = "¥ " + sumOfValue.description
        
        // 注文リストが空になるので確認ボタンを無効化する
        confirmButton.isEnabled = false
        confirmButton.backgroundColor = .gray
    }
    // 注文内容を確認で確認画面を表示
    @IBAction func confirmOrderButtonAction(_ sender: Any) {
        let orderConfirmVC = UIStoryboard(name: "StayingScreen", bundle: nil).instantiateViewController(withIdentifier: "orderConfirmViewController") as! OrderConfirmViewController
        orderConfirmVC.orderList = self.orderList
        present(orderConfirmVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 全てのUIの初期状態をセット
        selectedCellLabel.text = "商品を選択してください"
        selectedCellLabel.textColor = .gray
        selectedValueLabel.text = "¥ 0"
        selectedQuantityLabel.text = "数量:0"
        quantityStepper.isEnabled = false
        addButton.isEnabled = false
        addButton.backgroundColor = .gray
        
        sumOfQuantityLabel.text = "0 点"
        sumOfValueLabel.text = "¥ 0"
        confirmButton.isEnabled = false
        confirmButton.backgroundColor = .gray
        
        foodTable.allowsMultipleSelection = false // テーブルのセルを単数選択に限定する
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        yakitoriList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = yakitoriList[indexPath.row].name
        cell.detailTextLabel?.text = "¥ " + yakitoriList[indexPath.row].value.description
        cell.selectionStyle = .none
        
        return cell
    }
    
    // 商品が１つ選ばれた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark // チェックマークをつける
        selectedCellLabel.text = yakitoriList[indexPath.row].name // 選択された料理名を表示
        selectedValue = yakitoriList[indexPath.row].value // 選択された料理の価格を代入
        selectedValueLabel.text = "¥ " + selectedValue.description // 選択された料理の価格を表示
        
        quantityStepper.isEnabled = true // 初期状態で無効だったステッパーを有効化する
        addButton.isEnabled = true // 初期状態で無効だった追加ボタンを有効化する
        addButton.backgroundColor = .orange
        quantityStepper.value = 1
        selectedCellLabel.textColor = .label
        selectedQuantityLabel.text = "数量:" + Int(quantityStepper.value).description
    }
    
    // 選択されていた商品が選択解除された時の処理
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}
