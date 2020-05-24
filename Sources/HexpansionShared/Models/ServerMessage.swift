//
//  ServerMessage.swift
//  
//
//  Created by Andrew Haentjens on 26/04/2020.
//

import Foundation

/*
{
 "type": "join",
 "player": {
        "id":"621B5454-31F2-446B-9F36-FE22903D1CE7",
        "name":" Andrew",
        "color": null
        "ranking: 0
    }
 }
*/

public protocol Message: Codable { }

/// PLAYER requests to join
public struct LobbyJoinRequest: Message {
    let player: Player
    
    public init(player: Player) {
        self.player = player
    }
}

/// PLAYER created on server and sent back (with assiged color)
public struct JoinedLobby: Message {
    let player: Player

    public init(player: Player) {
        self.player = player
    }
}

/// Player is set to ready
public struct Ready: Message {
    let player: Player

    public init(player: Player) {
        self.player = player
    }
}

/// game is full
public struct GameFull: Message {
    let error: PlayerError

    public init(error: PlayerError) {
        self.error = error
    }
}

/// ACTIVE PLAYER's turn, with the tapped TILE
public struct Turn: Message {
    let tile: Tile
    let activePlayer: Player
    
    public init(tile: Tile, activePlayer: Player) {
        self.tile = tile
        self.activePlayer = activePlayer
    }
}

/// Board gets updated and returns AFFECTED TILES and the new ACTIVE PLAYER
public struct ResolveTurn: Message {
    let affectedTiles: [Tile]
    let activePlayer: Player
    
    public init(affectedTiles: [Tile], activePlayer: Player) {
        self.affectedTiles = affectedTiles
        self.activePlayer = activePlayer
    }
}

/// Game is finished, WINNING PLAYER is returned allong with final state of the board's AFFECTED TILES
public struct Finish: Message {
    let affectedTiles: [Tile]
    let winner: Player

    public init(affectedTiles: [Tile], winner: Player) {
        self.affectedTiles = affectedTiles
        self.winner = winner
    }
}

/// Game was stopped by PLAYER
public struct StopGame: Message {
    let error: PlayerError
    
    public init(error: PlayerError) {
        self.error = error
    }
}

public enum MessageType: String, Codable {
    case requestToJoinLobby = "join"
    case joinedLobby = "joined"
    case ready = "ready"
    case full = "full"
    case turn = "turn"
    case resolveTurn = "resolve"
    case finish = "finish"
    case stop = "stop"
}

public struct ServerMessage: Codable {

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey  {
        case type, message
    }

    // MARK: - Properties

    public let type: MessageType
    public let message: Message

    // MARK: - Initializer

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(MessageType.self, forKey: .type)

        switch type {

        case .requestToJoinLobby:
            message = try container.decode(LobbyJoinRequest.self, forKey: .message)

        case .joinedLobby:
            message = try container.decode(JoinedLobby.self, forKey: .message)

        case .ready:
            message = try container.decode(Ready.self, forKey: .message)

        case .full:
            message = try container.decode(GameFull.self, forKey: .message)

        case .turn:
            message = try container.decode(Turn.self, forKey: .message)

        case .resolveTurn:
            message = try container.decode(ResolveTurn.self, forKey: .message)

        case .finish:
            message = try container.decode(Finish.self, forKey: .message)

        case .stop:
            message = try container.decode(StopGame.self, forKey: .message)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        do {
            try container.encode(type, forKey: .type)

            if let nMessage = message as? LobbyJoinRequest {
                try container.encode(nMessage, forKey: .message)
            } else if let nMessage = message as? JoinedLobby {
                try container.encode(nMessage, forKey: .message)
            } else if let nMessage = message as? Ready {
                try container.encode(nMessage, forKey: .message)
            } else if let nMessage = message as? GameFull {
                try container.encode(nMessage, forKey: .message)
            } else if let nMessage = message as? Turn {
                try container.encode(nMessage, forKey: .message)
            } else if let nMessage = message as? ResolveTurn {
                try container.encode(nMessage, forKey: .message)
            } else if let nMessage = message as? Finish {
                try container.encode(nMessage, forKey: .message)
            } else if let nMessage = message as? StopGame {
                try container.encode(nMessage, forKey: .message)
            }
        } catch(let error) {
            throw CodingError.encoding("Failed to encode Player: \(error)")
        }
    }

    private init(type: MessageType, message: Message) {
        self.type = type
        self.message = message
    }

    // MARK: - Static methods

    public static func joining(_ join: LobbyJoinRequest) -> ServerMessage {
        ServerMessage(type: .requestToJoinLobby, message: join)
    }

    public static func joined(_ joined: JoinedLobby) -> ServerMessage {
        ServerMessage(type: .joinedLobby, message: joined)
    }

    public static func gameIsFull(_ full: GameFull) -> ServerMessage {
        ServerMessage(type: .full, message: full)
    }

    public static func setReady(_ ready: Ready) -> ServerMessage {
        ServerMessage(type: .ready, message: ready)
    }

    public static func stop(_ stopGame: StopGame) -> ServerMessage {
        ServerMessage(type: .stop, message: stopGame)
    }

    public static func turn(_ turn: Turn) -> ServerMessage {
        ServerMessage(type: .turn, message: turn)
    }

    public static func resolveTurn(_ resolvedTurn: ResolveTurn) -> ServerMessage {
        ServerMessage(type: .resolveTurn, message: resolvedTurn)
    }

    public static func finish(_ finish: Finish) -> ServerMessage {
        ServerMessage(type: .finish, message: finish)
    }
}
