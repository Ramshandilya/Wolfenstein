//
//  Color.swift
//  Wolfenstein
//
//  Created by Ramsundar Shandilya on 4/20/20.
//  Copyright © 2020 Ramsundar Shandilya. All rights reserved.
//

import Foundation

struct Color {
    var r, g, b: UInt8
    var a: UInt8 = 255
}

extension Color {
    static let clear = Color(r: 0, g: 0, b: 0, a: 0)
    static let black = Color(r: 0, g: 0, b: 0)
    static let white = Color(r: 255, g: 255, b: 255)
    static let gray = Color(r: 192, g: 192, b: 192)
    static let red = Color(r: 255, g: 0, b: 0)
    static let green = Color(r: 0, g: 255, b: 0)
    static let blue = Color(r: 0, g: 0, b: 255)
}
