//
//  Player.swift
//  
//
//  Created by Andrew Haentjens on 26/04/2020.
//

import Foundation

/* Player JSON Object
 
    "player": {
        "id": "621B5454-31F2-446B-9F36-FE22903D1CE7",
        "name": "Andrew",
        "color": null
        "ranking": 0
        "isReady": true
    }
*/

public class Player: Codable {

    // MARK: - CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case color
        case ranking
        case isReady
    }

    // MARK: - Properties

    public let id: String
    public var name: String
    public var color: String?
    public var ranking: Int // Might be used later, but no users are saved atm.
    public var isReady: Bool

    // MARK: - Initializers

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        do {
            id = try values.decode(String.self, forKey: .id)
            name = try values.decode(String.self, forKey: .name)
            color = try values.decodeIfPresent(String.self, forKey: .color)
            ranking = try values.decode(Int.self, forKey: .ranking)
            isReady = try values.decode(Bool.self, forKey: .isReady)
        } catch(let error) {
            throw CodingError.decoding("Failed to decode Player: \(error)")
        }
    }

    public init(id: String, name: String) {
        self.id = id
        self.name = name
        self.ranking = 0
        self.isReady = false
    }

    // MARK: - Public methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        do {
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(color, forKey: .color)
            try container.encode(ranking, forKey: .ranking)
            try container.encode(isReady, forKey: .isReady )
        } catch(let error) {
            throw CodingError.encoding("Failed to encode Player: \(error)")
        }
    }
}

extension Player: Equatable {

    public static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
}

extension Player: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
