//
//  ViewController.swift
//  ojisanCamera
//
//  Created by 河合 徳光 on 2015/11/02.
//  Copyright © 2015年 norimitsu kawai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraImgView: UIImageView!
    let stamp = UIImage(named: "ojisan.png")            // スタンプ画像
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPushed(sender: AnyObject) {
        // ----- カメラを起動する
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let stampViews = cameraImgView.subviews
        for stampView in stampViews {
            stampView.removeFromSuperview()                     // スタンプをリセットする
        }
        cameraImgView.image = image                             // 撮影した画像をセットする
        cameraImgView.addSubview(UIImageView(image: stamp))     // スタンプ画像を合成する
        
        // ----- 合成した画像を保存する
        UIGraphicsBeginImageContext(cameraImgView.bounds.size)
        cameraImgView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        UIImageWriteToSavedPhotosAlbum(UIGraphicsGetImageFromCurrentImageContext(), self, nil, nil)
        UIGraphicsEndImageContext()
        
        dismissViewControllerAnimated(true, completion: nil)    // アプリ画面へ戻る
    }

}

