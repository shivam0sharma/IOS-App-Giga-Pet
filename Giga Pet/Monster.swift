//
//  Monster.swift
//  Giga Pet
//
//  Created by Shivam Sharma on 5/23/17.
//  Copyright © 2017 ShivamSharma. All rights reserved.
//

import Foundation
import UIKit

class Monster: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        playIdleAnimation()
    }
    
    func playIdleAnimation() {
        self.image = UIImage(named: "idle1.png")
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        for x in 1...4 {
            let image = UIImage(named: "idle\(x).png")
            imageArray.append(image!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        for x in 1...4 {
            let image = UIImage(named: "dead\(x).png")
            imageArray.append(image!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
}
