//
//  Rect.swift
//  Wolfenstein
//
//  Created by Ramsundar Shandilya on 4/20/20.
//  Copyright © 2020 Ramsundar Shandilya. All rights reserved.
//

import Foundation

struct Rect {
    var min: Vector
    var max: Vector
}

extension Rect {
    static func *(lhs: Rect, rhs: Double) -> Rect {
        return Rect(min: lhs.min * rhs, max: lhs.max * rhs)
    }
}

extension Rect {
    func intersection(with other: Rect) -> Vector? {
        let left = Vector(x: max.x - other.min.x, y: 0)
        if left.x <= 0 { return nil }

        let right = Vector(x: min.x - other.max.x, y: 0)
        if right.x >= 0 { return nil }

        let top = Vector(x: 0, y: max.y - other.min.y)
        if top.y <= 0 { return nil }

        let bottom = Vector(x: 0, y: min.y - other.max.y)
        if bottom.y >= 0 { return nil }

        return [left, right, top, bottom].sorted(by: { $0.length < $1.length }).first
    }
}
