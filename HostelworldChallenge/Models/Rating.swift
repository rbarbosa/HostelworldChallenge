//
//  Rating.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 04/12/2024.
//

struct Rating {
    let overall: Int
    let numberOfRatings: Int
}

// MARK: - Mocks

#if DEBUG
extension Rating {
    static var mock: Self {
        .init(overall: 82, numberOfRatings: 400)
    }
}
#endif
