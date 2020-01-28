//
//  ViewController.swift
//  Dice Roller
//
//  Created by Felix Mbikogbia  on 1/15/20.
//  Copyright © 2020 Felix Mbikogbia . All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{
    
    @IBOutlet weak var diceImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var criticalLowView: UITextView!
    @IBOutlet weak var criticalHighView: UITextView!
    @IBOutlet weak var button: UIButton!
    //this is where a text displays to show that you just hit a critical low or high e.g "wow, critical high!!"
    @IBOutlet weak var criticalLable: UILabel!
    
    let diceArray = [#imageLiteral(resourceName: "d1"), #imageLiteral(resourceName: "d2"), #imageLiteral(resourceName: "d3"), #imageLiteral(resourceName: "d4"), #imageLiteral(resourceName: "d5"), #imageLiteral(resourceName: "d6"), #imageLiteral(resourceName: "d7"), #imageLiteral(resourceName: "d8"), #imageLiteral(resourceName: "d9"), #imageLiteral(resourceName: "d10"), #imageLiteral(resourceName: "d11"), #imageLiteral(resourceName: "d12"), #imageLiteral(resourceName: "d13"), #imageLiteral(resourceName: "d14"), #imageLiteral(resourceName: "d15"), #imageLiteral(resourceName: "d16"), #imageLiteral(resourceName: "d17"), #imageLiteral(resourceName: "d18"), #imageLiteral(resourceName: "d19"), #imageLiteral(resourceName: "d20")]
    
    var defaultImage = #imageLiteral(resourceName: "d1")
    func setDefaultImage(_ sender: Any) {
        diceImageView.image = defaultImage
    }
    
    var str1 = "Times rolled: "
    var cLowString = "CL: " //number of lows
    var cHighString = "CH: " //number of highs
    
    var totalRolled = 0 //total number dice is rolled
    var numberPressed = 0 //this is the random number rolled
    var cLow = 0 //number of lows (dice = 1)
    var cHigh = 0 //number of highs (dice = 20)
    
    @IBAction func rollButton(_ sender: Any) {
        numberPressed = Int.random(in: 0...19)
        diceImageView.image = diceArray[numberPressed]
        
        var cLowString = "CL: "
        var cHighString = "CH: "
        if(numberPressed == 0){
            criticalLable.text = "You lost, sucker!"
            criticalLable.textColor = .red
            criticalLable.isHidden = false
            cLow += 1
            cLowString = cLowString + String(cLow)
            criticalLowView.text = cLowString
            criticalLowView.textColor = .red
            
        }else if(numberPressed == 19){
            criticalLable.text = "Wow!! Critical Hit!"
            criticalLable.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            criticalLable.isHidden = false
            
            cHigh += 1
            cHighString = cHighString + String(cHigh)
            criticalHighView.text = cHighString
            criticalHighView.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        }
        else{
            criticalLable.isHidden = true
        }
        
        rollSound.play()
        rollSound.currentTime = 0;
        
        if (numberPressed == 0) {
            failSound.play()
        }
        
        if (numberPressed == 19) {
            passSound.play()
        }
        let str1 = "Times rolled: "
        totalRolled += 1
        textView.text = str1 + String(totalRolled)
    }
    
    var rollSound:AVAudioPlayer = AVAudioPlayer()
    var failSound:AVAudioPlayer = AVAudioPlayer()
    var passSound:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultImage(defaultImage)
        textView.text = str1
        
        cLowString = cLowString + String(cLow)
        criticalLowView.text = cLowString
        criticalLowView.textColor = .red
        
        cHighString = cHighString + String(cHigh)
        criticalHighView.text = cHighString
        criticalHighView.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        
        do{
            let rollAudioPlayer = Bundle.main.path(forResource: "rolldice", ofType: "mp3")
        try rollSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: rollAudioPlayer!) as URL)
        }catch{
            //ERROR
        }
        
        do{
            let failAudioPlayer = Bundle.main.path(forResource: "failwah", ofType: "mp3")
            try failSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: failAudioPlayer!) as URL)
        } catch{
            //ERROR
        }
        
        do{
            let criticalRollAudio = Bundle.main.path(forResource: "torpedo", ofType: "mp3")
            try passSound = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: criticalRollAudio!) as URL)
        } catch{
            //ERROR
        }
        
    }
    
}

