//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var whenTimerEnds: UILabel!
    @IBOutlet weak var barProgressView: UIProgressView!
    
    var eggTime = ["Soft" : 5, "Medium" : 7, "Hard" : 12]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = (eggTime[hardness]!) * 60
        setupTimer()
        barProgressView.progress = 0.0
        secondsPassed = 0
        whenTimerEnds.text = hardness
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeFires), userInfo: nil, repeats: true)
    }
    
    @objc func timeFires() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            barProgressView.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            whenTimerEnds.text = "DONE!"
            playSound()
          }
    }
    
    func playSound() {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player!.play()
    }
}
