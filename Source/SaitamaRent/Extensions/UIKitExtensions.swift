//
//  UIViewExtensions.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable extension UIView {

    /* The color of the shadow. Defaults to opaque black. Colors created
     * from patterns are currently NOT supported. Animatable. */
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.CGColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(CGColor:color)
            }
            else {
                return nil
            }
        }
    }

    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
     * [0,1] range will give undefined results. Animatable. */
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }

    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }

    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }

    /* The additional corner radius set up. Animatable. */
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}

// MARK: External methods for simplyfying things
func perform_after(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

extension UIColor {

    enum ColorFormat: Int {

        case RGB = 12
        case RGBA = 16
        case RRGGBB = 24
        case RRGGBBAA = 32

        init?(bitsCount: Int) {
            self.init(rawValue: bitsCount)
        }

    }

    /**
     Returns color with given hex string
     */
    convenience init(string: String) {

        let string = string.stringByReplacingOccurrencesOfString("#", withString: "")

        if
            let hex = Int(string, radix: 16),
            let format = ColorFormat(bitsCount: string.characters.count * 4) {

            self.init(hex: hex, format: format)

        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
        }

    }

    /**
     Returns color with given hex integer value and color format
     */
    convenience init(hex: Int, format: ColorFormat = ColorFormat.RRGGBB) {

        var red = 0, green = 0, blue = 0, alpha = 255

        switch format {
        case .RGB:
            red   = ((hex & 0xf00) >> 8) << 4 + ((hex & 0xf00) >> 8)
            green = ((hex & 0x0f0) >> 4) << 4 + ((hex & 0x0f0) >> 4)
            blue  = ((hex & 0x00f) >> 0) << 4 + ((hex & 0x00f) >> 0)
            break;
        case .RGBA:
            red   = ((hex & 0xf000) >> 12) << 4 + ((hex & 0xf000) >> 12)
            green = ((hex & 0x0f00) >>  8) << 4 + ((hex & 0x0f00) >>  8)
            blue  = ((hex & 0x00f0) >>  4) << 4 + ((hex & 0x00f0) >>  4)
            alpha = ((hex & 0x000f) >>  0) << 4 + ((hex & 0x000f) >>  4)
            break;
        case .RRGGBB:
            red   = ((hex & 0xff0000) >> 16)
            green = ((hex & 0x00ff00) >>  8)
            blue  = ((hex & 0x0000ff) >>  0)
            break;
        case .RRGGBBAA:
            red   = ((hex & 0xff00000) >> 24)
            green = ((hex & 0x00ff0000) >> 16)
            blue  = ((hex & 0x0000ff00) >>  8)
            alpha = ((hex & 0x000000ff) >>  0)
            break;
        }

        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha)/255.0)

    }

}
