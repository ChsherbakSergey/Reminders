//
//  CustomTabBar.swift
//  Reminders
//
//  Created by Sergey on 12/2/20.
//

import Foundation
import UIKit

class CustomTabBar : UITabBar {
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        createShape()
    }
    
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        super.point(inside: point, with: event)
//        let buttonRadius: CGFloat = 40
//        return abs(self.center.x - point.x) > buttonRadius || abs(point.y) > buttonRadius
//    }
    
    private func createShape() {
        let shapeLayer = CAShapeLayer()
//        shapeLayer.path = createBezierPath()
        shapeLayer.path = createCirclePath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.systemGray6.withAlphaComponent(0.8).cgColor
        shapeLayer.lineWidth = 1.0
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }
    
    func createBezierPath() -> CGPath {
        
        let height: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0)) //start top left
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0))
        
        //fist curve down
        path.addCurve(to: CGPoint(x: centerWidth, y: height),
                      controlPoint1: CGPoint(x: (centerWidth - 30), y: 0),
                      controlPoint2: CGPoint(x: centerWidth - 35, y: height))
        //second curve up
        path.addCurve(to: CGPoint(x: centerWidth + height * 2, y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 35, y: height),
                      controlPoint2: CGPoint(x: centerWidth + 30, y: 0))
        //complete the rect
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        
        return path.cgPath
    }
    
    func createCirclePath() -> CGPath {
        
        let radius: CGFloat = 45.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        
        path.move(to: CGPoint(x: 0, y: 0)) //start top left
        path.addLine(to: CGPoint(x: (centerWidth - radius * 2), y: 0))
        path.addArc(withCenter: CGPoint(x: centerWidth, y: 0),
                    radius: radius,
                    startAngle: CGFloat(180).degreesToRadians,
                    endAngle: CGFloat(0).degreesToRadians,
                    clockwise: false)
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        return path.cgPath
    }
    
}
