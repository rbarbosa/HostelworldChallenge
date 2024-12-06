//
//  DetailedRating.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 06/12/2024.
//

struct DetailedRating: Decodable, Hashable, Equatable {
    let overall: Int
    let atmosphere: Int
    let cleanliness: Int
    let facilities: Int
    let staff: Int
    let security: Int
    let location: Int
    let valueForMoney: Int

    func averageRating() -> Double {
        let components = [
            overall,
            atmosphere,
            cleanliness,
            facilities,
            staff,
            security,
            location,
            valueForMoney
        ]

        let values = components.map { Double($0) }

        let average = values.reduce(0, +) / Double(values.count)
        
        return (average * 10).rounded() / 100
    }
}

// MARK: - Mocks

#if DEBUG
extension DetailedRating {
    static var mock: Self {
        .init(
            overall: 82,
            atmosphere: 71,
            cleanliness: 86,
            facilities: 80,
            staff: 95,
            security: 87,
            location: 77,
            valueForMoney: 81
        )
    }
}
#endif
