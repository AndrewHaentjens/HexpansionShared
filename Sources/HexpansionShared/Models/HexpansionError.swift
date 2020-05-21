//
//  HexpansionError.swift
//  
//
//  Created by Andrew Haentjens on 21/05/2020.
//

import Foundation

// MARK: - Player

enum PlayerCodingError: LocalizedError {
    case decoding(String)
    case encoding(String)

    var localizedDescription: String {
        switch self {
        case .decoding(let errorMessage), .encoding(let errorMessage):
            return errorMessage
        }
    }
}

enum PlayerError: LocalizedError {
    case nameTaken
    case gameIsFull
    
    var localizedDescription: String {
        switch self {
            
        case .nameTaken:
            return "The other player has already taken this name."

        case .gameIsFull:
            return "The lobby is full, try again later."
        }
    }
}
