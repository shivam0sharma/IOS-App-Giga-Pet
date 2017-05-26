//
//  DragImage.swift
//  Giga Pet
//
//  Created by Shivam Sharma on 5/23/17.
//  Copyright © 2017 ShivamSharma. All rights reserved.
//

import Foundation
import UIKit

class DragImage: UIImageView {
    var originalPosition: CGPoint!
    var dropTarget: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        originalPosition = self.center
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self.superview)
            self.center = CGPoint(x: position.x, y: position.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let target = dropTarget {
            let postion = touch.location(in: self.superview?.superview)
            
            if target.frame.contains(postion) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "onTargetDropped"), object: nil)
            }
        }
        
        self.center = originalPosition
    }
}
