//
//  Message.swift
//  
//
//  Created by Andrew Haentjens on 26/04/2020.
//

import Foundation

public enum MessageType: String, Codable {
    case join = "join"
    case turn = "turn"
    case finish = "finish"
    case stop = "stop"
}

public struct Message: Codable {

    // MARK: - Properties

    public let type: MessageType
    public let board: Board?
    public let player: Player?

    // MARK: - Initializer
    
    private init(type: MessageType, board: Board? = nil, player: Player? = nil) {
        self.type = type
        self.board = board
        self.player = player
    }

    // MARK: - Static methods

    public static func join(player: Player) -> Message {
        return Message(type: .join, board: nil, player: player)
    }
    
    public static func stop() -> Message {
        return Message(type: .stop, board: nil)
    }
    
    public static func turn(board: Board, player: Player?) -> Message {
        return Message(type: .turn, board: board, player: player)
    }
    
    public static func finish(board: Board, winningPlayer: Player?) -> Message {
        return Message(type: .finish, board: board, player: winningPlayer)
    }
}
