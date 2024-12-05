//
//  PropertiesRepository.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 05/12/2024.
//

import Foundation

struct PropertiesRepository {
    var fetchCityProperties: (_ cityId: String) async throws -> CityPropertiesResponse
}
