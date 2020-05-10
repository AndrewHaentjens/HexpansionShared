//
//  Message.swift
//  
//
//  Created by Andrew Haentjens on 26/04/2020.
//

import Foundation

/*
{
 "type":"join",
 "player":
    {
        "id":"621B5454-31F2-446B-9F36-FE22903D1CE7",
        "name":"Andrew",
        "color":null
    }
 }
*/

public enum MessageType: String, Codable {
    case joining = "joining" // request to join
    case joined = "joined" // waiting for other players
    case full = "full" // game is full
    case turn = "turn" // set turn
    case finish = "finish" // finish game
    case stop = "stop" // stop game
}

public struct Message: Codable {

    // MARK: - Properties

    public let type: MessageType
    public let board: Board?
    public let tile: Tile?
    public let player: Player?

    // MARK: - Initializer
    
    private init(type: MessageType, board: Board? = nil, tile: Tile? = nil, player: Player? = nil) {
        self.type = type
        self.board = board
        self.tile = tile
        self.player = player
    }

    // MARK: - Static methods

    public static func joining(player: Player) -> Message {
        return Message(type: .joining, player: player)
    }

    public static func joined(player: Player) -> Message {
        return Message(type: .joined, player: player)
    }

    public static func gameIsFull() -> Message {
        return Message(type: .full)
    }
    
    public static func stop() -> Message {
        return Message(type: .stop)
    }
    
    public static func turn(tile: Tile, player: Player?) -> Message {
        return Message(type: .turn, tile: tile, player: player)
    }
    
    public static func finish(board: Board, winningPlayer: Player?) -> Message {
        return Message(type: .finish, board: board, player: winningPlayer)
    }
}
