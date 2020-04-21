//
//  Renderer.swift
//  Wolfenstein
//
//  Created by Ramsundar Shandilya on 4/20/20.
//  Copyright © 2020 Ramsundar Shandilya. All rights reserved.
//

import Foundation

struct Renderer {
    var bitmap: Bitmap

    init(width: Int, height: Int) {
        bitmap = Bitmap(width: width, height: height, color: .black)
    }
    
    mutating func draw(world: World) {
        let worldWidth = 8.0
        let worldHeight = 8.0
        let scale = Double(bitmap.width) / worldWidth

        for y in 0..<world.map.height {
            for x in 0..<world.map.width {
                guard world.map[x, y].isWall else { continue }
                let min = Vector(x: Double(x) * scale, y: Double(y) * scale)
                let rect = Rect(
                    min: min,
                    max: min + Vector(x: scale, y: scale))
                bitmap.fill(rect: rect, color: .white)
            }
        }
        bitmap.fill(rect: world.player.rect * scale, color: .blue)
        let end = world.map.hitTest(Ray(origin: world.player.position, direction: world.player.direction)) * scale
        bitmap.drawLine(from: world.player.position * scale, to: end, color: .green)

        let focalLength = 1.0
        let planeWidth = 1.0
        let viewCenter = world.player.position + world.player.direction * focalLength
        let viewStart = viewCenter - world.player.direction.orthogonal * planeWidth / 2
        let viewEnd = viewCenter + world.player.direction.orthogonal * planeWidth / 2
        bitmap.drawLine(from: viewStart * scale, to: viewEnd * scale, color: .red)
    }
}
