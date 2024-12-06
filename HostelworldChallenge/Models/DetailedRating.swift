//
//  DetailedRating.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 06/12/2024.
//

struct DetailedRating {
    let overall: String
    let atmosphere: String
    let cleanliness: String
    let facilities: String
    let staff: String
    let security: String
    let location: String
    let valueForMoney: String
}

// MARK: - Mocks

#if DEBUG
extension DetailedRating {
    static var mock: Self {
        .init(
            overall: "82",
            atmosphere: "71",
            cleanliness: "86",
            facilities: "80",
            staff: "95",
            security: "87",
            location: "77",
            valueForMoney: "81"
        )
    }
}
#endif
