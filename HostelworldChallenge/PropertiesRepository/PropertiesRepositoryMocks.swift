//
//  PropertiesRepositoryMocks.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 05/12/2024.
//

// MARK: - Mocks

#if DEBUG
extension PropertiesRepository {
    static var success: Self {
        .init(
            fetchCityProperties: { _ in .init(properties: [.mock]) },
            fetchPropertyDetails: {_  in .mock }
        )
    }

    static var failure: Self {
        .init(
            fetchCityProperties: { _ in throw NetworkingError.invalidResponse },
            fetchPropertyDetails: { _ in throw NetworkingError.invalidResponse }
        )
    }

    static var longLoading: Self {
        .init(
            fetchCityProperties: { _ in
                try await Task.sleep(for: .seconds(20))
                return .init(properties: [.mock])
            },
            fetchPropertyDetails: { _ in
                try await Task.sleep(for: .seconds(20))
                return .mock
            }
        )
    }

    static var shortLoading: Self {
        .init(
            fetchCityProperties: { _ in
                try await Task.sleep(for: .seconds(2))
                return .init(properties: [.mock])
            },
            fetchPropertyDetails: { _ in
                try await Task.sleep(for: .seconds(2))
                return .mock
            }
        )
    }
}
#endif
