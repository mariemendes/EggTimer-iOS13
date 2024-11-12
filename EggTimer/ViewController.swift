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
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var player: AVAudioPlayer!
    let eggTimes = ["Soft" : 5, "Medium" : 7, "Hard" : 12]
    var timer = Timer()
        
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        if let result = eggTimes[hardness] {
            countdownTimer(time: result)
            progressBar.progress = 0.0
        } else {
            print("not available")
        }
    }
    func countdownTimer(time: Int) {
        //stop the counting
        timer.invalidate()
        var secondsRemaining = time * 60 // inicial time * the minuts of egg to be ready
        
        // print at all seconds
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if secondsRemaining > 0 {
//                print("\(secondsRemaining) seconds. ")
                secondsRemaining -= 1
                let progress = Float(time * 60 - secondsRemaining) / Float(time * 60)
                self.progressBar.progress = progress
            } else {
                self.playSound()
                self.titleLabel.text = "Done"
                timer.invalidate() //when its zero
            }
        }
        // keep the looping runing
        RunLoop.current.run()
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}
