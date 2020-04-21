//
//  World.swift
//  Wolfenstein
//
//  Created by Ramsundar Shandilya on 4/20/20.
//  Copyright © 2020 Ramsundar Shandilya. All rights reserved.
//

import Foundation

struct World {
    var player: Player
    var map: Tilemap

    mutating func update(timestep: Double, input: Vector) {
        player.update(timestep: timestep, input: input)
        while let intersection = player.intersection(with: map) {
            player.position += intersection
        }
    }
}
