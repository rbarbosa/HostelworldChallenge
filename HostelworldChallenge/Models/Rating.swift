//
//  Rating.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 04/12/2024.
//

struct Rating {
    let numberOfRatings: Int
    let overall: Int?
}

// MARK: - Decodable conformance

extension Rating: Decodable { }

// MARK: - Mocks

#if DEBUG
extension Rating {
    static var mock: Self {
        .init(numberOfRatings: 400, overall: 82)
    }
}
#endif
