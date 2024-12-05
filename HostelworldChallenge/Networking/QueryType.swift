//
//  QueryType.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 05/12/2024.
//

// MARK: - Query type

enum QueryType {
    case cityProperties(cityId: String)
    case property(propertyId: String)

    var path: String {
        switch self {
        case .cityProperties(let cityId): 
            "/cities/\(cityId)/properties/"

        case .property(let propertyId):
            "/properties/\(propertyId)"
        }
    }
}
