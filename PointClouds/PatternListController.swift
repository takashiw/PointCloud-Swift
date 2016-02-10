//
//  PatternListController.swift
//  PointClouds
//
//  Created by David Lee on 2016. 2. 10..
//  Copyright © 2016년 dhlee. All rights reserved.
//

import UIKit

class PatternListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var _library = PointCloudLibrary.getDemoLibrary()
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = _library.pointClouds[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _library.pointClouds.count
    }
}