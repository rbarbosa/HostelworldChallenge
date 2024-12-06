//
//  City.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 04/12/2024.
//

struct City: Equatable, Hashable {
    let id: String
    let name: String
    let country: String
}

// MARK: - Decodable conformance

extension City: Decodable { }

// MARK: - Mocks

#if DEBUG
extension City {
    static var mock: Self {
        City(
            id: "1530",
            name: "Gothenburg",
            country: "Sweden"
        )
    }
}
#endif
