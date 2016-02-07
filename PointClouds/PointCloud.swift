import UIKit

class PointCloud {
    let origin = Point(x:0.0, y:0.0, id:0)
    
    // get the center point from points.
    func centroid(points:[Point]) -> Point {
        var _x = 0.0
        var _y = 0.0
        
        for point in points {
            _x += point.x
            _y += point.y
        }
        
        _x /= Double(points.count)
        _y /= Double(points.count)
        
        return Point(x:_x, y:_y, id:0)
    }
    
    func pathLength(points:[Point]) -> Double {
        var d = 0.0
        
        // 경고
        for index in (1..<points.count) {
            let p1 = points[index]
            let p2 = points[index-1]
            
            if(p1.id == p2.id){
                d += distance(p1, p2:p2)
            }
        }
        
        return d
    }
    
    func avgPointDistance(points1:[Point], points2:[Point]) -> Double? {
        if(points1.count != points2.count) {
            return nil
        } else {
            var _d = 0.0
            
            for index in (0..<points1.count) {
                _d += distance(points1[index], p2: points2[index])
            }
            
            return _d / Double(points1.count)
        }
    }
 
    // get distance between two points.
    func distance(p1:Point, p2:Point) -> Double {
        let dx = p2.x - p1.x
        let dy = p2.y - p1.y
        return sqrt(dx * dx + dy * dy)
    }
}