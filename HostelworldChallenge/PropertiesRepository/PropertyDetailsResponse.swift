//
//  PropertyDetailsResponse.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 06/12/2024.
//

import Foundation

func makePropertyDetailsResponse(from data: Data) throws -> PropertyDetails {
    do {
        return try JSONDecoder().decode(PropertyDetails.self, from: data)
    } catch {
        throw NetworkingError.decodingFailed(error)
    }
}
