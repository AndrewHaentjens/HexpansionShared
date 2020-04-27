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

public struct Tile: Codable {

    public var id: Int
    public var location: TileLocation
    public var state: TileState
    public var value: Int

    public var owner: Player?

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
