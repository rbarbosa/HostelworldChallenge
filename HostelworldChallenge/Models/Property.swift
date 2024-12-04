//
//  Property.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 04/12/2024.
//

import Foundation

struct Property {
    let id: String
    let name: String
    let city: City
    let type: String
    let overallRating: Rating
    let images: [String]
}

// MARK: - Mocks

#if DEBUG
extension Property {
    static var mock: Property {
        Property(
            id: "32849",
            name: "STF Vandrarhem Stigbergsliden",
            city: .mock,
            type: "Hostel",
            overallRating: .mock,
            images: ["http://ucd.hwstatic.com/propertyimages/3/32849/7.jpg"]
        )
    }
}
#endif

