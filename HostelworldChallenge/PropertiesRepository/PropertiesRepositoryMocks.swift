//
//  PropertiesRepositoryMocks.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 05/12/2024.
//

// MARK: - Mocks

extension PropertiesRepository {
    static var success: Self {
        .init(
            fetchCityProperties: { _ in .init(properties: [.mock]) }
        )
    }
}
