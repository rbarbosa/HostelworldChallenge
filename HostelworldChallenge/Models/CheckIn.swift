//
//  CheckIn.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 06/12/2024.
//

struct CheckIn: Equatable, Hashable, Decodable {
    let startsAt: String
    let endsAt: String
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
