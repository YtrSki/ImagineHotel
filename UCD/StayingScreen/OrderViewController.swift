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
        selectedQuantityLabel.text = "数量:" + quantityStepper.value.description
    }
    @IBAction func addButtonAction(_ sender: Any) {
        // 注文リストに追加する
        for _ in 0 ..< Int(quantityStepper.value) {
            orderList += [Yakitori(name: selectedCellLabel.text!, value: selectedValue)]
        }
        
        // 注文点数を更新する
        sumOfQuantityLabel.text = orderList.count.description + " 点"
        
        // 合計価格を更新する
        for v in orderList {
            sumOfValue += v.value
        }
        sumOfValueLabel.text = "¥ " + sumOfValue.description
    }
    
    @IBAction func confirmOrderButtonAction(_ sender: Any) {
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
        
        sumOfQuantityLabel.text = "0 点"
        sumOfValueLabel.text = "0 点"
        confirmButton.isEnabled = false
        
        foodTable.allowsMultipleSelection = false
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
        selectedCellLabel.text = yakitoriList[indexPath.row].name // 選択された料理名を代入
        selectedValue = yakitoriList[indexPath.row].value // 選択された料理の価格を代入
        selectedValueLabel.text = "¥ " + selectedValue.description
        
        quantityStepper.isEnabled = true // 初期状態で無効だったステッパーを有効化する
        addButton.isEnabled = true // 初期状態で無効だった追加ボタンを有効化する
        quantityStepper.value = 1
        selectedCellLabel.textColor = .black
        selectedQuantityLabel.text = "数量:1"
    }
    
    // 選択されていた商品が選択解除された時の処理
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}
