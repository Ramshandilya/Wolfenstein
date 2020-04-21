//
//  Renderer3D.swift
//  Wolfenstein
//
//  Created by Ramsundar Shandilya on 4/21/20.
//  Copyright © 2020 Ramsundar Shandilya. All rights reserved.
//

import Foundation

struct Renderer3D {
    var bitmap: Bitmap

    init(width: Int, height: Int) {
        bitmap = Bitmap(width: width, height: height, color: .black)
    }

    mutating func draw(world: World) {
        let focalLength = 1.0
        let planeWidth = 1.0
        let viewCenter = world.player.position + world.player.direction * focalLength
        let viewStart = viewCenter - world.player.direction.orthogonal * planeWidth / 2

        var position = viewStart
        let columns = bitmap.width
        let step = world.player.direction.orthogonal * planeWidth / Double(columns)

        for col in 0..<columns {
            let end = position - world.player.position
            let ray = Ray(origin: world.player.position, direction: end / end.length)

            let wallIntersection = world.map.hitTest(ray)
            position += step

            let wallDistance = wallIntersection - world.player.position
            let wallHeight = 1.0
            let height = focalLength * wallHeight / wallDistance.length * Double(bitmap.height)
            let wallStart = Vector(x: Double(col), y: (Double(bitmap.height) - height) / 2)
            let wallEnd = Vector(x: Double(col), y: (Double(bitmap.height) + height) / 2)

            let wallColor = wallIntersection.x.rounded() == wallIntersection.x ? Color.white : .gray
            bitmap.drawLine(from: wallStart, to: wallEnd, color: wallColor)
        }
    }
}
