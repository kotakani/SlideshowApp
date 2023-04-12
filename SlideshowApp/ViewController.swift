//
//  ViewController.swift
//  SlideshowApp
//
//  Created by yamadakota on 2023/03/30.
//

import UIKit

class ViewController: UIViewController {
    
    // slideshowの画像(ボタン)
    @IBOutlet weak var imageButton: UIButton!
    
    // 写真のリスト
    var imageList = ["sunset.png", "dog.png", "city.png", "cat.png"]
    // imageListのインデックス
    var imageListNumber = 0
    // 再生/停止の状態
    var stateSlideshow = false
    
    // タイマー
    var timer: Timer!
    // タイマー用の時間のための変数
    var timer_sec: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 画像を設定
        imageButton.setImage(UIImage(named: imageList[imageListNumber]), for: .normal)
    }
    
    // selector: #selector(updateTimer(_:))で指定された関数
    // timeInterval: 1, repeats: trueで指定されたとおり，1秒ごとに呼び出され続ける
    @objc func updateTimer(_ timer: Timer) {
        self.timer_sec += 1
        if (self.timer_sec % 2 == 0) {
            if imageListNumber != (imageList.count - 1) {
                imageListNumber += 1
            } else {
                imageListNumber = 0
            }
            imageButton.setImage(UIImage(named: imageList[imageListNumber]), for: .normal)
        }
    }
    
    // 進むボタン
    @IBAction func forwardButton(_ sender: Any) {
        if stateSlideshow == false {
            if imageListNumber != (imageList.count - 1) {
                imageListNumber += 1
            } else {
                imageListNumber = 0
            }
            imageButton.setImage(UIImage(named: imageList[imageListNumber]), for: .normal)  // imageButtonの画像変更
        }
    }
    
    // 戻るボタン
    @IBAction func backButton(_ sender: Any) {
        if stateSlideshow == false {
            if imageListNumber != 0 {
                imageListNumber -= 1
            } else {
                imageListNumber = (imageList.count - 1)
            }
            imageButton.setImage(UIImage(named: imageList[imageListNumber]), for: .normal)
        }
    }
    
    // 再生&停止ボタン
    @IBAction func slideshowButton(_ sender: Any) {
        stateSlideshow.toggle()  // stateSlideshowの真偽値を反転させる
        if stateSlideshow {
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            }
        } else {
            if self.timer != nil {
                self.timer.invalidate()  // タイマーを停止する
                self.timer = nil
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のResultViewControllerを取得する
        let resultViewController: ResultViewController = segue.destination as! ResultViewController
        // 遷移先のResultViewControllerで宣言しているimageListとimageListNumberに値を代入して渡す
        resultViewController.imageList = imageList
        resultViewController.imageListNumber = imageListNumber
        
        resultViewController.stateSlideshow = stateSlideshow
        resultViewController.timer = timer
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        // 他の画面からsegueを使って戻ってきた時に呼ばれる
        // タイマーを停止する
        stateSlideshow = false
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
        }
    }


}












