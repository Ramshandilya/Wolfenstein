//
//  Player.swift
//  Wolfenstein
//
//  Created by Ramsundar Shandilya on 4/20/20.
//  Copyright © 2020 Ramsundar Shandilya. All rights reserved.
//

import Foundation

struct Player {
    var position: Vector
    var velocity: Vector
    var direction: Vector
    
    let radius: Double = 0.25
    let speed: Double = 2
    let turningSpeed = 2.0

    mutating func update(timestep: Double, input: Vector) {
        direction = direction.rotate(by: input.x * turningSpeed * timestep)
        velocity = -input.y * direction * speed

        position += velocity * timestep
        position.x.formTruncatingRemainder(dividingBy: 8)
        position.y.formTruncatingRemainder(dividingBy: 8)
    }

    var rect: Rect {
        let half = Vector(x: radius, y: radius)
        return Rect(min: position - half, max: position + half)
    }

    func intersection(with map: Tilemap) -> Vector? {
        let playerRect = self.rect
        let minX = Int(rect.min.x)
        let maxX = Int(rect.max.x)
        let minY = Int(rect.min.y)
        let maxY = Int(rect.max.y)
        var largestIntersection: Vector?

        for y in minY...maxY {
            for x in minX...maxX {
                let min = Vector(x: Double(x), y: Double(y))
                let wallRect = Rect(min: min, max: min + Vector(x: 1, y: 1))
                if map[x, y].isWall,
                    let intersection = wallRect.intersection(with: playerRect) {
                    if intersection.length > (largestIntersection?.length ?? 0) {
                        largestIntersection = intersection
                    }
                }
            }
        }

        return largestIntersection
    }
}
