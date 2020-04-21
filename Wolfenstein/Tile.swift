//
//  Tile.swift
//  Wolfenstein
//
//  Created by Ramsundar Shandilya on 4/20/20.
//  Copyright © 2020 Ramsundar Shandilya. All rights reserved.
//

import Foundation

enum Tile: Int, Decodable {
    case nothing = 0
    case wall = 1

    var isWall: Bool {
        switch self {
        case .wall:
            return true
        case .nothing:
            return false
        }
    }
}

struct Tilemap: Decodable {
    let width: Int
    let tiles: [Tile]

    var height: Int {
        tiles.count / width
    }

    subscript(x: Int, y: Int) -> Tile {
        tiles[y*width + x]
    }
}

extension Tilemap {
    func hitTest(_ ray: Ray) -> Vector {
        var position = ray.origin
        repeat {
            var edgeDistanceX: Double
            var edgeDistanceY: Double

            if ray.direction.x > 0 {
                edgeDistanceX = position.x.rounded(.down) + 1 - position.x
            } else {
                edgeDistanceX = position.x.rounded(.up) - 1 - position.x
            }
            if ray.direction.y > 0 {
                edgeDistanceY = position.y.rounded(.down) + 1 - position.y
            } else {
                edgeDistanceY = position.y.rounded(.up) - 1 - position.y
            }

            let slope = ray.direction.x / ray.direction.y
            let horizontalDelta = Vector(x: edgeDistanceX, y: edgeDistanceX / slope)
            let verticalDelta = Vector(x: edgeDistanceY * slope, y: edgeDistanceY)
            if horizontalDelta.length < verticalDelta.length {
                position += horizontalDelta
            } else {
                position += verticalDelta
            }
        } while !self.tile(at: position, direction: ray.direction).isWall

        return position
    }

    func tile(at position: Vector, direction: Vector) -> Tile {
        let x = Int(position.x)
        let y = Int(position.y)

        if position.x.rounded() == position.x {
            let xIndex = direction.x > 0 ? x : x - 1
            return self[xIndex, y]
        } else {
            let yIndex = direction.y > 0 ? y : y - 1
            return self[x, yIndex]
        }
    }
}
