//
//  File.swift
//  
//
//  Created by Andrew Haentjens on 26/04/2020.
//

import Foundation

/* Board JSON Object
    "Board": {
        "id": 1,
        "name": "The Classic Arena",
        "totalItemsInRow": 10,
        "totalItemsInColumn": 9,
        "Tiles": [{
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
        },
        ... ]
    }
*/
public struct Board: Codable {
    public let id: Int
    public let name: String
    public let totalItemsInRow: Int
    public let totalItemsInColumn: Int
    public let tiles: [Tile]

    /// Temporary init for hardcode board
    private init(id: Int, name: String, totalItemsInRow: Int, totalItemsInColumn: Int, playerOne: Player, playerTwo: Player) {
        self.id = id
        self.name = name
        self.totalItemsInRow = totalItemsInRow
        self.totalItemsInColumn = totalItemsInColumn
        
        let numberOfTiles = totalItemsInColumn * totalItemsInRow
        let ineligableTiles = [
            0, 1, 7, 8, 9, 10, 11, 18, 19, 20, 28, 29, 30, 39, 42, 46, 49, 50, 59, 60, 68, 69, 70, 71, 78, 79, 80, 81, 87, 88, 89
        ]
        let playerOneStartingPosition = 2
        let playerTwoStartingPosition = 86

        var nTiles: [Tile] = []
        for i in 0..<numberOfTiles {
            if ineligableTiles.contains(i) {
                let location = TileLocation(row: i / totalItemsInRow, column: i % totalItemsInRow)
                let tile = Tile(id: i, state: .ineligable, location: location)
                nTiles.append(tile)
            } else if playerOneStartingPosition == i {
                let location = TileLocation(row: i / totalItemsInRow, column: i % totalItemsInRow)
                let playerOneStartingTile = Tile(id: i, state: .owned(playerOne), location: location)
                nTiles.append(playerOneStartingTile)
            } else if playerTwoStartingPosition == i {
                let location = TileLocation(row: i / totalItemsInRow, column: i % totalItemsInRow)
                let playerTwoStartingTile = Tile(id: i, state: .owned(playerTwo), location: location)
                nTiles.append(playerTwoStartingTile)
            } else {
                let location = TileLocation(row: i / totalItemsInRow, column: i % totalItemsInRow)
                let freeTile = Tile(id: i, state: .free, location: location)
                nTiles.append(freeTile)
            }
        }

        tiles = nTiles
    }

    public static func getClassicArenaBoard(playerOne: Player, playerTwo: Player) -> Board {
        return Board(id: 1,
                     name: "The Classic Arena",
                     totalItemsInRow: 10,
                     totalItemsInColumn: 9,
                     playerOne: playerOne,
                     playerTwo: playerTwo)
    }
}
