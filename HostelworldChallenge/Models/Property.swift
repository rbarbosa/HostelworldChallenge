//
//  Property.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 04/12/2024.
//

import Foundation

struct Property: Identifiable {
    let id: String
    let name: String
    let city: City
    let type: String
    let overallRating: Rating
    let images: [String]
}

// MARK: - Decodable conformance

extension Property: Decodable {

    enum CodingKeys: CodingKey {
        case id
        case name
        case city
        case type
        case overallRating
        case images
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.city = try container.decode(City.self, forKey: .city)
        self.type = try container.decode(String.self, forKey: .type)
        self.overallRating = try container.decode(Rating.self, forKey: .overallRating)

        let imageObjects = try container.decode([ImageObject].self, forKey: .images)
        self.images = imageObjects.map {
            ($0.prefix + $0.suffix).replacingOccurrences(of: "http://", with: "https://")
        }
    }
}

// Helper struct to decode the image objects

private struct ImageObject: Decodable {
    let prefix: String
    let suffix: String
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
            images: ["https://ucd.hwstatic.com/propertyimages/3/32849/7.jpg"]
        )
    }

    static var mock2: Property {
        Property(
            id: "40919",
            name: "Backpackers Göteborg",
            city: .mock,
            type: "Apartment",
            overallRating: .mock2,
            images: ["https://ucd.hwstatic.com/propertyimages/4/40919/5.jpg"]
        )
    }
}
#endif

