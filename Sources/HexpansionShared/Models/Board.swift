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
    let id: Int
    let name: String
    let totalItemsInRow: Int
    let totalItemsInColumn: Int
    let tiles: [Tile]
}
