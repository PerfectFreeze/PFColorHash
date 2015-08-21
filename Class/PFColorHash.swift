//
//  PFColorHash.swift
//  PFColorHash
//
//  Created by Cee on 20/08/2015.
//  Copyright (c) 2015 Cee. All rights reserved.
//

import Foundation

public class PFColorHash {
    
    lazy var lightness: [Double] = [0.35, 0.5, 0.65]
    
    lazy var saturation: [Double] = [0.35, 0.5, 0.65]
    
    lazy var hash = { (str: String) -> Int in
        let seed1 = 131
        let seed2 = 137
        var ret = 0
        var hashString = str + "x"
        let maxSafeInt: Int = 9007199254740991 / seed2
        for (index, element) in enumerate(hashString) {
            if (ret > maxSafeInt) {
                ret = ret / seed2
            }
            ret = ret * seed1 + element.unicodeScalarCodePoint()
        }
        return ret
    }
    
    // MARK: Init Methods
    init() {}
    
    init(lightness: [Double]) {
        self.lightness = lightness
    }
    
    init(saturation: [Double]) {
        self.saturation = saturation
    }
    
    init(lightness: [Double], saturation: [Double]) {
        self.lightness = lightness
        self.saturation = saturation
    }
    
    init(hash: (String) -> Int) {
        self.hash = hash
    }
    
    // MARK: Public Methods
    final func hsl(str: String) -> (h: Double, s: Double, l: Double) {
        var hashValue = hash(str)
        let h = hashValue % 359
        hashValue = hashValue / 360
        let s = saturation[hashValue % saturation.count]
        hashValue = hashValue / saturation.count
        let l = lightness[hashValue % lightness.count]
        return (Double(h), Double(s), Double(l))
    }

    
    final func rgb(str: String) -> (r: Int, g: Int, b: Int) {
        let hslValue = hsl(str)
        return hsl2rgb(hslValue.h, s: hslValue.s, l: hslValue.l)
    }
    
    final func hex(str: String) -> String {
        let rgbValue = rgb(str)
        return rgb2hex(rgbValue.r, g: rgbValue.g, b: rgbValue.b)
    }
    
    // MARK: Private Methods
    private final func hsl2rgb(h: Double, s: Double, l:Double) -> (r: Int, g: Int, b: Int) {
        let hue = h / 360
        var q = l < 0.5 ? l * (1 + s) :l + s - l * s
        var p = 2 * l - q
        let array = [hue + 1/3, hue, hue - 1/3].map({ (color: Double) -> Int in
                var ret = color
                if (ret < 0) {
                    ret = ret + 1
                }
                if (ret > 1) {
                    ret = ret - 1
                }
                if (ret < 1 / 6) {
                    ret = p + (q - p) * 6 * ret
                } else if (ret < 0.5) {
                    ret = q
                } else if (ret < 2 / 3) {
                    ret = p + (q - p) * 6 * (2 / 3 - ret)
                } else {
                    ret = p
                }
                return Int(ret * 255)
            }
        )
        return (array[0], array[1], array[2])
    }
    
    private final func rgb2hex(r: Int, g: Int, b: Int) -> String {
        return String(format:"%X", r) + String(format:"%X", g) + String(format:"%X", b)
    }
}

// MARK: Character To ASCII
extension Character
{
    func unicodeScalarCodePoint() -> Int
    {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return Int(scalars[scalars.startIndex].value)
    }
}