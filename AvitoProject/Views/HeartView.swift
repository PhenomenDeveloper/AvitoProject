//
//  HeartView.swift
//  AvitoProject
//
//  Created by Lev Kolesnikov on 31/07/2019.
//  Copyright © 2019 phenomendevelopers. All rights reserved.
//

import UIKit

// Реализация "Сердечка" через отделный компонент
@IBDesignable
class HeartView: UIView {

    @IBInspectable var heartColor: UIColor? = .red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var heartPosition: CGPoint = .zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var heartSize: CGSize = CGSize(width: 25, height: 25) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var strokeWidth: CGFloat = 2.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var isHeartHidden: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var filled: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    var heartHitHandler: (() -> Void)?

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard !isHeartHidden else {
            curPath = nil
            return
        }
        
        let path = getHeartPath(in: CGRect(origin: heartPosition, size: heartSize))
        
        if self.heartColor != nil {
            self.heartColor!.setStroke()
        } else {
            self.tintColor.setStroke()
        }
        
        path.lineWidth = strokeWidth
        
        path.stroke()
        
        if self.filled {
            self.tintColor.setFill()
            path.fill()
        }
        
        curPath = path
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let curPath = curPath else { return }
        
        let hit = touches.contains { touch -> Bool in
            let touchPoint = touch.location(in: self)
            return curPath.contains(touchPoint)
        }
        if hit {
            heartHitHandler?()
        }
    }
    
    private var curPath: UIBezierPath?
    
    private func getHeartPath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.lineWidth = strokeWidth
        
        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
        
        path.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        
        path.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))
        
        path.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        
        path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))
        
        path.close()
        
        return path
    }

}
