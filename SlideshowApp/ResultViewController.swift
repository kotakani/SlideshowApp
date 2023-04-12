//
//  ResultViewController.swift
//  SlideshowApp
//
//  Created by yamadakota on 2023/03/31.
//

import UIKit

class ResultViewController: UIViewController {
    
    // 拡大画像
    @IBOutlet weak var largeImage: UIImageView!
    
    // 受け取るためのプロパティ(変数)を宣言しておく
    var timer: Timer!
    var stateSlideshow = false
    var imageListNumber = 0
    var imageList = ["sunset.png", "dog.png", "city.png", "cat.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // スライドショーが再生されていたら，停止する
        if stateSlideshow {
            stateSlideshow = false
            if timer != nil {
                timer.invalidate()  // タイマーを停止する
                timer = nil
            }
        }
        

        // Do any additional setup after loading the view.
        
        // 画像を設定
        let sampleImage = UIImage(named: imageList[imageListNumber])
        largeImage.image = sampleImage
        
        
    }

}
