//
//  HexpansionError.swift
//  
//
//  Created by Andrew Haentjens on 21/05/2020.
//

import Foundation

// MARK: - Connection

public enum ConnectionError: LocalizedError {
    
}

// MARK: - Player

public enum CodingError: LocalizedError {
    case decoding(String)
    case encoding(String)
    case unknownType(Any)

    var localizedDescription: String {
        switch self {
        case .decoding(let errorMessage), .encoding(let errorMessage):
            return errorMessage
        case .unknownType(let type):
            return "Unknown type: \(type)"
        }
    }
}

public enum PlayerError: String, LocalizedError, Codable {
    case nameTaken
    case gameIsFull
    case playerConceded
    
    var localizedDescription: String {
        switch self {
            
        case .nameTaken:
            return "The other player has already taken this name."

        case .gameIsFull:
            return "The lobby is full, try again later."

        case .playerConceded:
            return "The other player has conceded the game. You win!"
        }
    }
}
