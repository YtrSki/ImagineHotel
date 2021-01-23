//
//  CheckInViewController.swift
//  UCD
//
//  Created by YutaroSakai on 2021/01/22.
//  参考: https://www.letitride.jp/entry/2019/12/03/125802
//

import UIKit
import AVFoundation

class CheckInViewController: UIViewController {
    let myQRCodeReader = MyQRCodeReader()
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var topOverlayView: UIView!
    @IBOutlet weak var topOverlayLabel: UILabel!
    @IBAction func userAccountButtonAction(_ sender: Any) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if bookingList.count == 0 {
            topOverlayLabel.text = "先にご予約を追加してください"
            topOverlayLabel.textColor = .red
        }
        else {
            topOverlayLabel.text = "ホテルフロントにある\nチェックインQRコードを読み取ります"
            topOverlayLabel.textColor = .black
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*  QRコードリーダーのセットアップ  */
        myQRCodeReader.delegate = self
        myQRCodeReader.setupCamera(view:self.view)
        //読み込めるカメラ範囲
        myQRCodeReader.readRange()
        
        /*  UIのセットアップ  */
        self.view.bringSubviewToFront(overlayView)
        topOverlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let visualEffectView = UIVisualEffectView(frame: topOverlayView.frame)
        visualEffectView.effect = UIBlurEffect(style: .light)
        topOverlayView.insertSubview(visualEffectView, at: 0)
        
    }
}

extension CheckInViewController: AVCaptureMetadataOutputObjectsDelegate{
    //対象を認識、読み込んだ時に呼ばれる
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        //一画面上に複数のQRがある場合、複数読み込むが今回は便宜的に先頭のオブジェクトを処理
        if let metadata = metadataObjects.first as? AVMetadataMachineReadableCodeObject{
            let barCode = myQRCodeReader.previewLayer.transformedMetadataObject(for: metadata) as! AVMetadataMachineReadableCodeObject
            //読み込んだQRを映像上で枠を囲む。ユーザへの通知。必要な時は記述しなくてよい。
            myQRCodeReader.qrView.frame = barCode.bounds
            //QRデータを表示
            if let str = metadata.stringValue {
                if str.count > 0 && bookingList.count > 0 {
                    // チャックインする時の画面と処理
                    let confirmCheckInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "confirmCheckInViewController")
                    confirmCheckInVC.modalTransitionStyle = .crossDissolve
                    confirmCheckInVC.modalPresentationStyle = .overCurrentContext
                    present(confirmCheckInVC, animated: true, completion: nil)
                }
            }
        }
    }
}

// モーダルをdismissした後に利用中画面に遷移する処理を発動させるためのextension
extension ConfirmCheckInViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        
    }
}
