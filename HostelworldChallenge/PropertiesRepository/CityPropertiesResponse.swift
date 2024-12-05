//
//  CityPropertiesResponse.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 05/12/2024.
//

import Foundation

struct CityPropertiesResponse: Decodable {
    let properties: [Property]
}

func makeCityPropertiesResponse(from data: Data) throws -> CityPropertiesResponse {
    do {
        return try JSONDecoder().decode(CityPropertiesResponse.self, from: data)
    } catch {
        throw NetworkingError.decodingFailed(error)
    }
}
