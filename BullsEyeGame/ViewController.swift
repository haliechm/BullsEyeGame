//
//  ViewController.swift
//  BullsEyeGame
//
//  Created by haliechm on 12/20/19.
//  Copyright © 2019 Halie Chmura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // when streak >= 5 then something
    
    var sliderValue:Int = 0
    var targetValue:Int = 0
    var scoreValue:Int = 0
    var pointsScored:Int = 0
    var streakValue:Int = 0
    var roundNumberValue:Int = 1
    var overallhighscoreValue:Int = 0
    var currenthighscoreValue:Int = 0
    var currentscore:Int = 0
    var firstRound:Bool = true
    
    @IBOutlet weak var slider:UISlider!
    @IBOutlet weak var target:UILabel!
    @IBOutlet weak var score:UILabel!
    @IBOutlet weak var roundNumber:UILabel!
    @IBOutlet weak var streakNumber:UILabel!
    @IBOutlet weak var startOverButton:UIButton!
    @IBOutlet weak var highscore:UILabel!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValue = Int(slider.value.rounded())
        gameStarted()
    }
    
    @IBAction func hitMeButton() {
        
        firstRound = false
        
        let difference:Int = abs(sliderValue-targetValue)
        var message:String = ""
        
        if (difference == 0) {
            perfectRound()
        } else if (difference >= 50) {
            message = "\(sliderValue) Wow, that's terrible!"
            pointsScored = 0
            streakValue = 0
        } else if (difference >= 10) {
            message = "\(sliderValue) You can do better"
            pointsScored = 0
            streakValue = 0
        } else if (difference >= 5) {
            message = "\(sliderValue) Almost had it!"
            pointsScored = 100
            scoreValue += pointsScored
            streakValue = 0
        } else if (difference >= 1) {
            message = "\(sliderValue) So close!"
            if (streakValue >= 30) {
                pointsScored = 2000
            } else if (streakValue >= 15) {
                pointsScored = 1500
            } else if (streakValue >= 5) {
                pointsScored = 1000
            } else {
                pointsScored = 500
            }
            scoreValue += pointsScored
            streakValue += 1
        }
        
        currenthighscoreValue = scoreValue / roundNumberValue
        
        roundNumberValue += 1
        
        if (difference == 0) {
            
        } else {
        let alert = UIAlertController(title: message, message: "Off by \(difference)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Next Round", style: .default, handler: {action in self.updateLabels()})
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        }
     
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        sliderValue = Int(slider.value+0.5)
        
    }
    
    @IBAction func startOverButtonHit() {
        let soAlert = UIAlertController(title: "Start Over", message: "Are you sure you want to start over? All current progress will be lost", preferredStyle: .alert)
        
        let soAction = UIAlertAction(title: "Start Over", style: .default, handler: {action in self.startOver()})
        
        let secondsoAction = UIAlertAction(title: "No", style: .default, handler: {action in self.dontStartOver()})
        
        soAlert.addAction(soAction)
        soAlert.addAction(secondsoAction)
        
        present(soAlert, animated: true, completion: nil)
        
    }
    
    
    func gameStarted() {
        sliderValue = Int.random(in: 1...100)
        updateLabels()
    }
    
    func updateLabels() {
        targetValue = Int.random(in: 1...100)
        
        if (firstRound) {
            score.text = String(0)
        } else {
            score.text = String(scoreValue / (roundNumberValue-1))
        }
        target.text = String(targetValue)
        roundNumber.text = String(roundNumberValue)
        streakNumber.text = String(streakValue)
        
        
      
    }
    
    func startOver() -> Void {
        
        if (currenthighscoreValue > overallhighscoreValue) {
            highscore.text = String(currenthighscoreValue)
            overallhighscoreValue = currenthighscoreValue
        }
        
        scoreValue = 0
        streakValue = 0
        roundNumberValue = 1
        pointsScored = 0
        currenthighscoreValue = 0
        firstRound = true
        
        
//        updateLabels()
        gameStarted()
    }
    
    func dontStartOver() -> Void {
        
    }
    
    func perfectRound() {
        if (streakValue >= 30) {
            pointsScored = 4000
        } else if (streakValue >= 15) {
            pointsScored = 3000
        } else if (streakValue >= 5) {
            pointsScored = 2000
        } else {
            pointsScored = 1000
        }
        scoreValue += pointsScored
        
        streakValue += 1
        
        let alert = UIAlertController(title: "CONGRATULATIONS", message: "took ya long enough", preferredStyle: .alert)
        
        alert.view.tintColor = UIColor.lightGray
        alert.view.backgroundColor = UIColor.yellow
        
        let action = UIAlertAction(title: "I'm amazing", style: .default, handler: {action in self.updateLabels()})
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
       
    }
    


}

