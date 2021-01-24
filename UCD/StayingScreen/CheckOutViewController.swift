//
//  CheckOutViewController.swift
//  UCD
//
//  Created by YutaroSakai on 2021/01/24.
//

import UIKit
import AVFoundation

class CheckOutViewController: UIViewController {
    let myQRCodeReader = MyQRCodeReader()
    
    @IBOutlet weak var topOverlayView: UIView!
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*  QRコードリーダーのセットアップ  */
        myQRCodeReader.delegate = self
        myQRCodeReader.setupCamera(view:self.view)
        //読み込めるカメラ範囲
        myQRCodeReader.readRange()
        
        /*  UIのセットアップ  */
        self.view.bringSubviewToFront(topOverlayView)
        topOverlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let visualEffectView = UIVisualEffectView(frame: topOverlayView.frame)
        visualEffectView.effect = UIBlurEffect(style: .light)
        topOverlayView.insertSubview(visualEffectView, at: 0)
    }
    
}

extension CheckOutViewController: AVCaptureMetadataOutputObjectsDelegate {
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
                    self.isModalInPresentation = true
                    let confirmCheckOutVC = UIStoryboard(name: "StayingScreen", bundle: nil).instantiateViewController(withIdentifier: "confirmCheckOutViewController")
                    confirmCheckOutVC.modalTransitionStyle = .crossDissolve
                    confirmCheckOutVC.modalPresentationStyle = .overCurrentContext
                    present(confirmCheckOutVC, animated: true, completion: nil)
                }
            }
        }
    }
}
