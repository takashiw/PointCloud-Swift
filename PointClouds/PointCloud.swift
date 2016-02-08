import UIKit

class PointCloud {
    let origin = Point(x:0.0, y:0.0, id:0)
    let numPoints = 32
    
    
    // var keyword in function parameter makes it to be mutable.
    // resampling given points
    func resample(var points:[Point]) -> [Point] {
        let intervalLength = pathLength(points) / Double(numPoints - 1)
        var distance = 0.0
        var newPoints = [Point](count: numPoints, repeatedValue: Point(x: 0.0, y:0.0, id:0))
        newPoints[0] = Point(x: points[0].x, y:points[0].y, id:points[0].id)
        var k = 1;
        
        for i in 1..<points.count {
            let p1 = points[i]
            let p2 = points[i-1]
            if(p1.id == p2.id) {
                let d = getDistance(p2, p2:p1)
                if((distance + d) >= intervalLength){
                    let qx = p2.x + (((intervalLength - distance) / d) * (p1.x - p2.x))
                    let qy = p2.y + (((intervalLength - distance) / d) * (p1.y - p2.y))
                    let q = Point(x: qx, y: qy, id: p1.id)
                    
                    if(k < numPoints){
                        newPoints[k] = q
                        // 'q point' will be next p2
                        points[i] = q
                        k += 1
                    }
                } else {
                    distance += d
                }
            }
        }
        
        let lastPoint = points.last!
        newPoints[numPoints-1] = Point(x:lastPoint.x, y:lastPoint.y, id:lastPoint.id)
        
        return newPoints
    }
    
    func scale(points:[Point]) -> [Point] {
        var minX = Double.infinity
        var maxX = Double.infinity * -1.0
        var minY = Double.infinity
        var maxY = Double.infinity * -1.0
        
        for point in points {
            minX = min(minX, point.x)
            minY = min(minY, point.y)
            maxX = max(maxX, point.x)
            maxY = max(maxY, point.y)
        }
        
        let size = Double(max(maxX - minX, maxY - minY))
        var newPoints = [Point](count: points.count, repeatedValue: Point(x:0.0, y:0.0, id:0))
        
        for (index, point) in points.enumerate() {
            let qx = (point.x - minX) / size
            let qy = (point.y - minY) / size
            newPoints[index] = Point(x:qx, y:qy, id:point.id)
        }
        
        return newPoints
    }
    
    // move this points to specific point that is passed as second parameter.
    func translateTo(points:[Point], pt:Point) -> [Point] {
        let c = centroid(points)
        var newPoints = [Point](count: points.count, repeatedValue: Point(x:0.0, y:0.0, id:0))
        
        for (index, point) in points.enumerate() {
            let qx = point.x + pt.x - c.x
            let qy = point.y + pt.y - c.x
            newPoints[index] = Point(x:qx, y:qy, id:point.id)
        }
        
        return newPoints
    }
    
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
                d += getDistance(p2, p2:p1)
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
                _d += getDistance(points1[index], p2: points2[index])
            }
            
            return _d / Double(points1.count)
        }
    }
 
    // get distance between two points.
    func getDistance(p1:Point, p2:Point) -> Double {
        let dx = p2.x - p1.x
        let dy = p2.y - p1.y
        return sqrt(dx * dx + dy * dy)
    }
}