//
//  Tile.swift
//  
//
//  Created by Andrew Haentjens on 26/04/2020.
//

import Foundation

/* Tile JSON object
    "Tile": {
        "id": 0,
        "State": {
            "eligable": true,
            "owner": {
                "id": 1,
                "name": "Andrew",
                "color": #5DF54C
            }
        }
        "location": {
            "row": 0,
            "column": 0
        },
        "value": 0
    }
*/

public class Tile: Codable {

    public let id: Int
    public let location: TileLocation
    public var state: TileState
    public var value: Int

    public var owner: Player?

    /*
     Neighboring tiles for 2, 2 (row, column)
                (1, 2)          (1, 3)
     
            (2, 1)      (2, 2)      (2, 3)
     
                (3, 2)          (3, 3)

     Neighboring tiles for 3, 3 (row, column)
                (2, 2)          (2, 3)
     
            (3, 2)      (3, 3)      (3, 4)
     
                (4, 2)          (4, 3)
    */
    public var neighboringLocations: [TileLocation] {
        var neighboringLocations: [TileLocation] = []

        let isEvenRow = location.row % 2 == 0

        if isEvenRow {
            neighboringLocations.append(TileLocation(row: location.row - 1, column: location.column))
            neighboringLocations.append(TileLocation(row: location.row - 1, column: location.column + 1))
            neighboringLocations.append(TileLocation(row: location.row, column: location.column - 1))
            neighboringLocations.append(TileLocation(row: location.row, column: location.column + 1))
            neighboringLocations.append(TileLocation(row: location.row + 1, column: location.column))
            neighboringLocations.append(TileLocation(row: location.row + 1, column: location.column + 1))
        } else {
            neighboringLocations.append(TileLocation(row: location.row - 1, column: location.column - 1))
            neighboringLocations.append(TileLocation(row: location.row - 1, column: location.column))
            neighboringLocations.append(TileLocation(row: location.row, column: location.column - 1))
            neighboringLocations.append(TileLocation(row: location.row, column: location.column + 1))
            neighboringLocations.append(TileLocation(row: location.row + 1, column: location.column - 1))
            neighboringLocations.append(TileLocation(row: location.row + 1, column: location.column))
        }
        
        return neighboringLocations
    }

    public init(id: Int, state: TileState, location: TileLocation) {
        self.id = id
        self.location = location
        self.state = state
        
        switch state {

        case .free, .ineligable:
            self.value = 0

        case .owned(let player):
            self.value = 1
            self.owner = player
        }
    }
}

// MARK: - private methods

private extension Tile { }
