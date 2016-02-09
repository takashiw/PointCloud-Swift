//
//  PointDrawingCanvas.swift
//  PointClouds
//
//  Created by David Lee on 2016. 2. 9..
//  Copyright © 2016년 dhlee. All rights reserved.
//

import UIKit

class PointDrawingCanvas : UIView {
    var lastPoint = CGPoint.zero
    var tempImageView:UIImageView?
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        tempImageView = UIImageView(frame:frame)
        
        // or bit operator in
        // swift 1.2 : .FlexibleWidth | .FlexibleHeight -- Object Name is inferred
        // swift 2 : [.FlexibleWidth, .FlexibleHeight]
        tempImageView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        tempImageView!.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
        self.addSubview(tempImageView!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            lastPoint = touch.locationInView(self)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let point = touch.locationInView(self)
            print("x: \(point.x), y: \(point.y)")
        }
    }
}