//
//  PropertyDetails.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 06/12/2024.
//

import Foundation

struct PropertyDetails: Hashable, Equatable {
    let id: String
    let name: String
    let rating: DetailedRating?
    let description: String
    let address1: String
    let address2: String?
    let directions: String
    let city: City
    let totalRatings: String
    let images: [String]
    let type: String
    let checkIn: CheckIn
    let policies: [String]
}

extension PropertyDetails: Decodable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case description
        case address1
        case address2
        case directions
        case city
        case totalRatings
        case images
        case type
        case checkIn
        case policies
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decodeIfPresent(DetailedRating.self, forKey: .rating)
        description = try container.decode(String.self, forKey: .description)
        address1 = try container.decode(String.self, forKey: .address1)
        address2 = try container.decodeIfPresent(String.self, forKey: .address2)
        directions = try container.decode(String.self, forKey: .directions)
        city = try container.decode(City.self, forKey: .city)
        totalRatings = try container.decode(String.self, forKey: .totalRatings)
        type = try container.decode(String.self, forKey: .type)
        checkIn = try container.decode(CheckIn.self, forKey: .checkIn)
        policies = try container.decode([String].self, forKey: .policies)

        let imageObjects = try container.decode([ImageObject].self, forKey: .images)
        images = imageObjects.map {
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
extension PropertyDetails {
    static var mock: Self {
        .init(
            id: "32849",
            name: "STF Vandrarhem Stigbergsliden",
            rating: .mock,
            description: descriptionMock,
            address1: "Stigbergsliden 10",
            address2: nil,
            directions: directionsMock,
            city: .mock,
            totalRatings: "400",
            images: [
                "https://ucd.hwstatic.com/propertyimages/3/32849/7.jpg",
                "https://ucd.hwstatic.com/propertyimages/3/32849/1.jpg",
                "http://ucd.hwstatic.com/propertyimages/3/32849/2.jpg",
                "https://ucd.hwstatic.com/propertyimages/3/32849/3.jpg",
                "https://ucd.hwstatic.com/propertyimages/3/32849/4.jpg",
            ],
            type: "HOSTEL",
            checkIn: .mock,
            policies: [
                "Child Friendly",
                "Credit Cards Accepted",
                "No Curfew",
                "Non Smoking",
                "Pet Friendly",
                "Taxes Included"
            ]
        )
    }
}

private let descriptionMock: String = """
Set in a listed building from the mid-1800s in the trendy area of Majorna/Linné. This traditional, eco-friendly \
hostel  is a 12-minute tram ride from Gothenburg Central Station. 

The picturesque Haga and the vibrant street life of 'Långgatorna' with pubs, bars, restaurants and food markets is \
a 10 minutes walk away.

Tram 11 takes you to the unique soutern archipelago of Gothenburg in 20 minutes.

Free Wi-Fi.

2 fully equipped communal kitchens.

Each simply furnished room includes an in-room wash basin and a table with chairs. Bathroom facilities are shared.

Relax in the common dining area with TV or in the spacious green back yard with a furnished terrace. \
Daily newspapers and a wide range of touristic information is provided. 

Laundry facilities.

Pets are allowed on one floor, contact us directly to book this.
"""

private let directionsMock: String = """
Public transportation: Take the tram number 3, 9 or 11 to 'Stigbergstorget', it takes about 10 min from the \
centralstation. Walk back down the hill app 100m, the hostel will be on your right side.

Car: Drive towards 'centrum'. Follow the signs towards 'Fredrikshavn'. Chose exit 'Fiskhamnsmotet' and follow the sign \
to 'Majorna'. Turn left at the first traffic light to Karl Johansgatan and continue up the hill and down again, \
the street has now changed name to 'Stigbergsliden'. You find us on nr 10.
"""
#endif
