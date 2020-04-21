//
//  Bitmap.swift
//  Wolfenstein
//
//  Created by Ramsundar Shandilya on 4/20/20.
//  Copyright © 2020 Ramsundar Shandilya. All rights reserved.
//

import Foundation

struct Bitmap {
    var width: Int
    var pixels: [Color]

    var height: Int {
        pixels.count / width
    }

    subscript(x: Int, y: Int) -> Color {
        get { pixels[y * width + x] }
        set {
            guard y < height, x < width, y >= 0, x >= 0 else { return }
            pixels[y * width + x] = newValue
        }
    }

    init(width: Int, height: Int, color: Color) {
        self.width = width
        pixels = Array(repeating: color, count: width * height)
    }
}

extension Bitmap {
    mutating func fill(rect: Rect, color: Color) {
        for y in Int(rect.min.y)..<Int(rect.max.y) {
            for x in Int(rect.min.x)..<Int(rect.max.x) {
                self[x, y] = color
            }
        }
    }
}

