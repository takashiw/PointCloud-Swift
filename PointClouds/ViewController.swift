//
//  ViewController.swift
//  PointClouds
//
//  Created by David Lee on 2016. 2. 8..
//  Copyright © 2016년 dhlee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var lastPoint = CGPoint.zero
    @IBOutlet var drawingArea:UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("\(drawingArea!.frame.size.width)")
        print("\(drawingArea!.frame.size.height)")
        
        print("bound width: \(drawingArea!.bounds.width)")
        print("bound height: \(drawingArea!.bounds.height)")
        
        let canvas = PointDrawingCanvas(frame: drawingArea!.bounds)
        canvas.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        drawingArea!.addSubview(canvas)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Match pattern, then represent what it is in view controller.
    @IBAction func matchButtonPressed(sender:AnyObject?) {
        
    }
}

