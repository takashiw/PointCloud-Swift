import UIKit

class PointCloud {
    var name:String = ""
    var _points:[Point] = nil
    
    init(name:String, points:[Point]) {
        let modeler = PointCloudModeler()
        self.name = name
        
        _points = points
        _points = modeler.resample(_points)
        _points = modeler.translateTo(_points, Point(x:0.0, y:0.0, id:0))
        _points = modeler.scale(_points)
    }
    
    func greedyMatch(reference:PointCloud) -> Double {
        let pointCount = Double(_points.count)
        let e = 0.50
        let step = floor(pow(pointcount, 1.0 - e))
        var minValue = Double.infinity
        
        var i = 0.0
        while(i < pointCount) {
            let d1 = self.cloudDistance(reference, i)
            let d2 = reference.cloudDistance(self, i)
            minValue = min(minValue, min(d1, d2))
            i += step
        }
        
        return min
    }
    
    private func cloudDistance(reference:PointCloud, start:Double) -> Double? {
        let pts1 = _points
        let pts2 = reference._points
        let modeler = PointCloudModeler()
        
        if(pts1.count != pts2.count) {
            return nil
        }
        
        let pointCount = Double(_points.count)
        var matched = [Bool](count: _points.count, repeatedValue: false)
        
        var sum = Double(0)
        var i = start
        
        do {
            var index = -1
            var min = Double.infinity
            
            for j in 0..<matched.count; {
                if(!matched[j]) {
                    var d = modeler.getDistance(pts1[i], pts2[j])
                    if(d < min) {
                        min = d
                        index = j
                    }
                }
            }
            
            if(index != -1)
                matched[index] = true
            
            var weight = 1.0 - ((i - start + pointCount) % pointCount) / pointCount
            sum += weight * min
            i = (i + 1.0) % pointCount
        } while(i != start)
        
        return sum
    }
}
