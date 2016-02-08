import UIKit

class PointCloudLibrary {
    // empty point cloud array.
    var pointClouds = [PointCloud]()
    
    // return top related gesture from library
    func recognizeFromLibrary(inputGesture:PointCloud) -> MatchResult {
        var b = Double.infinity
        var u = -1
        
        for (index, pointCloud) in pointClouds.enumerate() {
            if let d = inputGesture.greedyMatch(pointCloud) {
                if(d < b) {
                    b = d
                    u = index
                }
            }
        }
        
        if(u == -1) {
            return MatchResult(name: "No match", score: 0.0)
        } else {
            let score = max((b - 2.0) / -2.0, 0.0)
            return MatchResult(name:pointClouds[u].name, score:score)
        }
    }
}
