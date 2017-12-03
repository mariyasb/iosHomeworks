//
//  ArrowControlView.swift
//  FirstHomework
//
//  Created by Maria Bozhkova on 11/25/17.
//  Copyright © 2017 Maria Bozhkova. All rights reserved.
//

import UIKit

@IBDesignable
class ArrowControlView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.black
    }
    
    let lightblue = UIColor(red: 0.15, green: 0.76, blue: 0.93, alpha: 1.0)
    
    let lightgrey = UIColor(red: 0.89, green: 0.90, blue: 0.90, alpha: 1.0)
    
    var scale = ["20","40","60","80","100"].map({ NSMutableAttributedString(string: $0, attributes:[NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font: UIFont(name: "helvetica", size: 20)!])})
    
    var colors = [UIColor.green, UIColor.yellow, UIColor.red, UIColor.blue, UIColor.purple]
    
    @IBInspectable
    var rotateAngle: Int = 90
    
    private var radius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * 0.8
    }
    
    private var circleCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private var arrowRadius: CGFloat {
        return radius/7
    }
    
    private func arrowPath() {
        let path = UIBezierPath(arcCenter: center, radius: arrowRadius, startAngle: CGFloat.pi/3, endAngle: 2*CGFloat.pi/3, clockwise: false)
        path.addLine(to: CGPoint(x: circleCenter.x, y: circleCenter.y+radius-20))
        path.close()
        
        lightblue.setFill()
        
        path.apply(CGAffineTransform(translationX: -center.x, y: -center.y))
        path.apply(CGAffineTransform(rotationAngle: CGFloat(rotateAngle) * CGFloat.pi / 180))
        path.apply(CGAffineTransform(translationX: center.x, y: center.y))
        
        path.fill()
    }
    
    private func circlePath() {
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: false)
        
        path.lineWidth = 20
        
        lightblue.setStroke()
        UIColor.white.setFill()
        
        path.stroke()
        path.fill()
    }
    
    private func innerCirclePath() {
        let path = UIBezierPath(arcCenter: center, radius: radius-5, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: false)
        
        path.lineWidth = 10
        
        lightgrey.setStroke()
        path.stroke()
    }
    
    private func segmentPath() {
        let segmentRadius = radius - 22
        let numradius = radius - 40
        var start: CGFloat = 3*CGFloat.pi/4
        var end = start + 3*CGFloat.pi/10
        
        let num = NSMutableAttributedString(string: "0", attributes:[NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font: UIFont(name: "helvetica", size: 20)!])
        
        var numPoint = CGPoint(x: center.x-CGFloat(5)+numradius*cos(start), y: center.y-CGFloat(14)+numradius*sin(start))
        
        num.draw(at: numPoint)
        
        var offset = CGFloat(0)
        for i in 0..<5 {
            let path = UIBezierPath(arcCenter: center, radius: segmentRadius, startAngle: CGFloat(start), endAngle: CGFloat(end), clockwise: true)
            path.lineWidth = 25
            colors[i].setStroke()
            path.stroke()
            numPoint = CGPoint(x: center.x-offset+numradius*cos(end), y: center.y-offset+numradius*sin(end))
            scale[i].draw(at: numPoint)
            drawDashes(startAngle: start)
            start = end
            end += 3*CGFloat.pi/10
            offset+=(CGFloat(i)+9)/2
        }
    }
    
    private func drawDashes(startAngle: CGFloat) {
        var angle = startAngle
        for i in 0..<5 {
            let startPoint = CGPoint(x: center.x + (radius-5)*cos(angle), y: center.y+(radius-5)*sin(angle))
            
            let endPoint: CGPoint
            
            if i == 0 {
                endPoint = CGPoint(x: center.x + (radius-45)*cos(angle), y: center.y+(radius-45)*sin(angle))
            } else {
                endPoint = CGPoint(x: center.x + (radius-35)*cos(angle), y: center.y+(radius-35)*sin(angle))
            }
            let path=UIBezierPath()
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            path.close()
            lightgrey.setStroke()
            path.lineWidth = 2
            path.stroke()
            angle += 3*CGFloat.pi/40
        }
    }
    
    override func draw(_ rect: CGRect) {
        circlePath()
        innerCirclePath()
        segmentPath()
        arrowPath()
        
    }

}
