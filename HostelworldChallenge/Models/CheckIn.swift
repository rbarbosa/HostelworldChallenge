//
//  CheckIn.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 06/12/2024.
//

struct CheckIn: Equatable, Hashable {
    let startsAt: String
    let endsAt: String
}

// MARK: - Decodable conformance

extension CheckIn: Decodable {
    private enum CodingKeys: String, CodingKey {
        case startsAt
        case endsAt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Sometimes the values are returned as String, others as an Int

        if let stringValue = try? container.decode(String.self, forKey: .startsAt) {
            self.startsAt = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .startsAt) {
            self.startsAt = String(intValue)
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .startsAt,
                in: container,
                debugDescription: "startsAt must be either String or Int"
            )
        }

        if let stringValue = try? container.decode(String.self, forKey: .endsAt) {
            self.endsAt = stringValue
        }
        else if let intValue = try? container.decode(Int.self, forKey: .endsAt) {
            self.endsAt = String(intValue)
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .endsAt,
                in: container,
                debugDescription: "endsAt must be either String or Int"
            )
        }
    }
}

// MARK: - Mocks

#if DEBUG
extension CheckIn {
    static var mock: Self {
        .init(
            startsAt: "14",
            endsAt: "17"
        )
    }
}
#endif
