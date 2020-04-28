//
//  Player.swift
//  
//
//  Created by Andrew Haentjens on 26/04/2020.
//

import Foundation

/* Player JSON Object
    "player": {
        "id": 1,
        "name": "Andrew",
        "color": #5DF54C
    }
*/
public class Player: Codable {

    // MARK: - Properties

    public let id: Int
    public var name: String
    public var color: String?

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

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case color
    }

    // MARK: - Initializers

    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        do {
            id = try values.decode(Int.self, forKey: .id)
            name = try values.decode(String.self, forKey: .name)
            color = try values.decode(String.self, forKey: .color)
        } catch(let error) {
            throw PlayerCodingError.decoding("Failed to decode Player: \(error)")
        }
    }

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    // MARK: - Public methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        do {
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(color, forKey: .color)
        } catch(let error) {
            throw PlayerCodingError.encoding("Failed to encode Player: \(error)")
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
