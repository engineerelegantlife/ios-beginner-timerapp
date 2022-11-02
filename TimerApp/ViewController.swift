//
//  ViewController.swift
//  TimerApp
//
//  Created by Tomo Shimizu on 2022/10/05.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var startTime: TimeInterval? = nil
    var timer = Timer()
    var isStarting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ボタンを角丸にする
        startButton.layer.cornerRadius = 25
    }
    
    @IBAction func tapStartButton(_ sender: Any) {
        if isStarting {
            timer.invalidate()
            startButton.setTitle("スタート", for: .normal)
            isStarting = false
        } else {
            startTime = Date.timeIntervalSinceReferenceDate
            timer = Timer.scheduledTimer(timeInterval: 0.01,
                                         target: self,
                                         selector: #selector(countTimer),
                                         userInfo: nil,
                                         repeats: true)
            
            startButton.setTitle("ストップ", for: .normal)
            isStarting = true
        }
    }
    
    @IBAction func tapResetButton(_ sender: Any) {
        timer.invalidate()
        startButton.setTitle("スタート", for: .normal)
        isStarting = false
        
        startTime = nil
        timerLabel.text = "00:00"
    }
    
    @objc func countTimer() {
        guard let startTime = self.startTime else { return }
        let time = Date.timeIntervalSinceReferenceDate - startTime
        let min = Int(time / 60)
        let sec = Int(time) % 60
        self.timerLabel.text = String(format: "%02d:%02d", min, sec)
    }
}
