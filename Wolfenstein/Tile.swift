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
