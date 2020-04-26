//
//  TileState.swift
//  
//
//  Created by Andrew Haentjens on 26/04/2020.
//

import UIKit

/* TileState JSON Object
    "state:" {
        "eligable": true,
        "owner": {
            "id": 1,
            "name": "Andrew",
            "color": #5DF54C
        }
    }
 
 */

public enum TileState: Codable {
    case free
    case ineligable
    case owned(Player)

    // MARK: - Enums

    private enum CodingKeys: String, CodingKey {
        case eligable
        case owner
    }

    enum TileStateCodingError: Error {
        case decoding(String)
        case encoding(String)
    }

    // MARK: - Properties
    
    var color: UIColor {
        switch self {

        case .free:
            return .darkGray

        case .ineligable:
            return .clear

        case .owned(let player):
            return player.color
        }
    }

    // MARK: - Initializers

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        do {
            let isEligable = try values.decode(Bool.self, forKey: .eligable)
            if let owner = try values.decodeIfPresent(Player.self, forKey: .owner) {
                self = .owned(owner)
            } else if isEligable {
                self = .free
            } else {
                self = .ineligable
            }
        } catch (let error) {
            throw TileStateCodingError.decoding("Failed to decode TileState: \(error)")
        }
    }

    // MARK: - public functions
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        do {
            switch self {
            
            case .free:
                try container.encode(true, forKey: .eligable)
            case .ineligable:
                try container.encode(false, forKey: .eligable)
            case .owned(let owner):
                try container.encode(true, forKey: .eligable)
                try container.encode(owner, forKey: .owner)
            }
        } catch (let error) {
            throw TileStateCodingError.encoding("Failed to encode TileState: \(error)")
        }
    }
}

// MARK: - Equatable

extension TileState: Equatable {

    public static func == (lhs: TileState, rhs: TileState) -> Bool {
        switch (lhs, rhs) {
            
        case (.free, .free):
            return true

        case (.ineligable, .ineligable):
            return true

        case (.owned, .owned):
            return true
            
        default:
            return false
        }
    }
}
