//
//  Extensions.swift
//  Learning
//
//  Created by Playground, Inc. on 2018/08/02.
//  Copyright © 2018年 Engineer. All rights reserved.
//

import UIKit


public extension UIColor {
    convenience init(hex: String, alpha: CGFloat) {
        let v = hex.map { String($0) } + Array(repeating: "0", count: max(6 - hex.count, 0))
        let r = CGFloat(Int(v[0] + v[1], radix: 16) ?? 0) / 255.0
        let g = CGFloat(Int(v[2] + v[3], radix: 16) ?? 0) / 255.0
        let b = CGFloat(Int(v[4] + v[5], radix: 16) ?? 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1.0)
    }
}


public extension UIImage {
    func croppingToCenterSquare() -> UIImage {
        let cgImage = self.cgImage!
        var newWidth = CGFloat(cgImage.width)
        var newHeight = CGFloat(cgImage.height)
        if newWidth > newHeight {
            newWidth = newHeight
        } else {
            newHeight = newWidth
        }
        let x = (CGFloat(cgImage.width) - newWidth)/2
        let y = (CGFloat(cgImage.height) - newHeight)/2
        let rect = CGRect(x: x, y: y, width: newWidth, height: newHeight)
        let croppedCGImage = cgImage.cropping(to: rect)!
        return UIImage(cgImage: croppedCGImage, scale: scale, orientation: self.imageOrientation)
    }
}

public extension NSObject {
    class var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

