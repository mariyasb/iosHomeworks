//
//  ArrowControlView.swift
//  FirstHomework
//
//  Created by Maria Bozhkova on 11/25/17.
//  Copyright © 2017 Maria Bozhkova. All rights reserved.
//

import UIKit

class ArrowControlView: UIView {
    let lightblue = UIColor(red: 0.15, green: 0.76, blue: 0.93, alpha: 1.0)
    let lightgrey = UIColor(red: 0.89, green: 0.90, blue: 0.90, alpha: 1.0)
    var scale = ["20","40","60","80","100"].map({ NSMutableAttributedString(string: $0) })
    var colors = [UIColor.green, UIColor.yellow, UIColor.red, UIColor.blue, UIColor.purple]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.black
    }
    
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
        path.addLine(to: CGPoint(x: circleCenter.x, y: circleCenter.y*1.4))
        path.close()
        
        lightblue.setFill()
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
        var start: CGFloat = 3*CGFloat.pi/4
        var end = start + 3*CGFloat.pi/10
        let num = NSMutableAttributedString(string: "0")
        for i in 0..<5 {
            let path = UIBezierPath(arcCenter: center, radius: radius-22, startAngle: CGFloat(start), endAngle: CGFloat(end), clockwise: true)
            path.lineWidth = 25
            colors[i].setStroke()
            path.stroke()
            let numPoint = CGPoint(x: path.currentPoint.x, y: path.currentPoint.y )
            scale[i].draw(at: numPoint)
            start = end
            end += 3*CGFloat.pi/10
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        circlePath()
        innerCirclePath()
        segmentPath()
        arrowPath()
        
    }

}
