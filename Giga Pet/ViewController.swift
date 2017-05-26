//
//  ViewController.swift
//  Giga Pet
//
//  Created by Shivam Sharma on 5/17/17.
//  Copyright © 2017 ShivamSharma. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: Monster!
    @IBOutlet weak var foodImg: DragImage!
    @IBOutlet weak var heartImg: DragImage!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: Timer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: NSNotification.Name(rawValue: "onTargetDropped"), object: nil)
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "cave-music", withExtension: "mp3")!)
            sfxBite = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "bite", withExtension: "wav")!)
            sfxHeart = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "heart", withExtension: "wav")!)
            sfxDeath = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "death", withExtension: "wav")!)
            sfxSkull = try AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "skull", withExtension: "wav")!)
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
        
        startTimer()
    }
    
    func itemDroppedOnCharacter(_ notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.isUserInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.isUserInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        if !monsterHappy {
            penalties += 1
            sfxSkull.play()
            
            if penalties == 1 {
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            } else if penalties == 2 {
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
            } else if penalties >= 3 {
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = OPAQUE
            }
            
            if penalties >= MAX_PENALTIES {
                gameOver()
            }
        }
        
        let rand = arc4random_uniform(UInt32(2))
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.isUserInteractionEnabled = false
            heartImg.alpha = OPAQUE
            heartImg.isUserInteractionEnabled = true
        } else {
            heartImg.alpha = DIM_ALPHA
            heartImg.isUserInteractionEnabled = false
            foodImg.alpha = OPAQUE
            foodImg.isUserInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
        
    }
    
    func gameOver() {
        timer.invalidate()
        monsterImg.playDeathAnimation()
        sfxDeath.play()
        timer.invalidate()
    }
}

