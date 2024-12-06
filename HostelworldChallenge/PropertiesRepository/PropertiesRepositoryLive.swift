//
//  PropertiesRepositoryLive.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 05/12/2024.
//

// MARK: - Live implementation

extension PropertiesRepository {
    static var live: Self {
        let networking = Networking()

        return .init(
            fetchCityProperties: { cityId in
                let data = try await networking.fetch(query: .cityProperties(cityId: cityId))
                return try makeCityPropertiesResponse(from: data)
            },
            fetchPropertyDetails: { propertyId in
                let data = try await networking.fetch(query: .property(propertyId: propertyId))
                return try makePropertyDetailsResponse(from: data)
            }
        )
    }
}
