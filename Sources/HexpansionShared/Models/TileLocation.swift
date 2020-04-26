//
//  TileLocation.swift
//  
//
//  Created by Andrew Haentjens on 26/04/2020.
//

import Foundation

/* Location JSON Object
    "location": {
        "row": 0,
        "column": 0
    }
*/

public struct TileLocation: Codable {
    let row: Int
    let column: Int
}
