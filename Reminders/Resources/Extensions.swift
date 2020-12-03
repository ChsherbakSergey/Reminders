//
//  Extensions.swift
//  Reminders
//
//  Created by Sergey on 12/2/20.
//

import Foundation
import UIKit

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}

extension UIView {
    
    public var width : CGFloat {
        return frame.size.width
    }
    
    public var height : CGFloat {
        return frame.size.height
    }
    
    public var top : CGFloat {
        return frame.origin.y
    }
    
    public var bottom : CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var left : CGFloat {
        return frame.origin.x
    }
    
    public var right : CGFloat {
        return frame.origin.x + frame.size.width
    }
    
}
