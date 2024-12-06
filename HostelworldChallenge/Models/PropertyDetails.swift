//
//  PropertyDetails.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 06/12/2024.
//

import Foundation

struct PropertyDetails {
    let id: String
    let name: String
    let rating: DetailedRating
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

// MARK: - Mocks

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
                "http://ucd.hwstatic.com/propertyimages/3/32849/7.jpg",
                "http://ucd.hwstatic.com/propertyimages/3/32849/1.jpg",
                "http://ucd.hwstatic.com/propertyimages/3/32849/2.jpg",
                "http://ucd.hwstatic.com/propertyimages/3/32849/3.jpg",
                "http://ucd.hwstatic.com/propertyimages/3/32849/4.jpg",
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
