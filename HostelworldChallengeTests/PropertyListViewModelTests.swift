//
//  PropertyListViewModelTests.swift
//  HostelworldChallengeTests
//
//  Created by Rui Barbosa on 09/12/2024.
//

import Testing
@testable import HostelworldChallenge

struct PropertyListViewModelTests {

    @Test("Initial state", .tags(.viewModels))
    func initialState() {
        let sut = PropertyListViewModel(
            initialState: .init(),
            repository: .success
        )

        #expect(sut.isFetchingDetails == false)
        #expect(sut.destination == nil)
        #expect(sut.showAlertDetailsError == false)
        #expect(sut.properties.isEmpty)
        #expect(sut.fetching == .idle)
        #expect(sut.fetchingDetails == .idle)
    }

    @Test("On appear should fetch properties", .tags(.viewModels))
    func onAppear() async throws {
        var repositoryCalled = false
        var repository: PropertiesRepository = .success

        repository.fetchCityProperties = { cityId in
            repositoryCalled = true
            #expect(cityId == "1530")
            return .init(properties: [.mock])
        }

        let sut = PropertyListViewModel(
            initialState: .init(),
            repository: repository
        )

        #expect(sut.fetching == .idle)
        sut.send(.onAppear)

        #expect(sut.fetching == .loading)

        // Give time for the async
        try await Task.sleep(for: .milliseconds(100))

        #expect(sut.fetching == .idle)

        #expect(sut.properties.count == 1)

        let property = try #require(sut.properties.first)
        #expect(property.id == "32849")
        #expect(property.name == "STF Vandrarhem Stigbergsliden")
        #expect(property.type == "Hostel")
        #expect(property.images.count == 1)

        #expect(repositoryCalled)
    }

    @Test("Unsuccessfully fetching properties should set failure state", .tags(.viewModels))
    func onUnsuccessfulPropertiesFetch() async throws {
        let sut = PropertyListViewModel(
            initialState: .init(),
            repository: .failure
        )

        #expect(sut.fetching == .idle)
        sut.send(.onAppear)

        #expect(sut.fetching == .loading)

        // Give time for the async
        try await Task.sleep(for: .milliseconds(100))

        #expect(sut.fetching == .failed)
    }

    @Test("Retry button tapped should fetch properties", .tags(.viewModels))
    func onRetryButtonTapped() async throws {
        var repositoryCalled = false
        var repository: PropertiesRepository = .success

        repository.fetchCityProperties = { cityId in
            repositoryCalled = true
            #expect(cityId == "1530")
            return .init(properties: [.mock])
        }

        let sut = PropertyListViewModel(
            initialState: .init(),
            repository: repository
        )

        #expect(sut.fetching == .idle)
        sut.send(.onAppear)

        #expect(sut.fetching == .loading)

        // Give time for the async
        try await Task.sleep(for: .milliseconds(100))

        #expect(sut.fetching == .idle)

        #expect(repositoryCalled)
    }

    @Test("Tapping on image should fetch property details", .tags(.viewModels))
    func onTapImage() async throws {
        var repositoryCalled = false
        var repository: PropertiesRepository = .success

        repository.fetchPropertyDetails = { propertyId in
            repositoryCalled = true
            #expect(propertyId == "32849")
            return .mock
        }

        let sut = PropertyListViewModel(
            initialState: .init(properties: [.mock]),
            repository: repository
        )

        #expect(sut.fetchingDetails == .idle)
        #expect(sut.isFetchingDetails == false)

        sut.send(.onImageTap(.mock))

        #expect(sut.fetchingDetails == .loading)
        #expect(sut.isFetchingDetails == true)

        // Give time for the async
        try await Task.sleep(for: .milliseconds(100))

        #expect(sut.fetchingDetails == .idle)
        #expect(sut.isFetchingDetails == false)

        #expect(repositoryCalled)
    }

    @Test("Successful property details fetch should set destination to details", .tags(.viewModels))
    func onSuccessfulPropertyDetailsFetch() async throws {
        let sut = PropertyListViewModel(
            initialState: .init(properties: [.mock]),
            repository: .success
        )

        sut.send(.onImageTap(.mock))

        // Give time for the async
        try await Task.sleep(for: .milliseconds(100))

        let destination = try #require(sut.destination)

        var propertyDetails: PropertyDetails?

        if case let .details(details) = destination {
            propertyDetails = details
        } else {
            #expect(Bool(false), "Expected .propertyDetails but got \(destination)")
        }

        let property = try #require(propertyDetails)
        #expect(property.name == "STF Vandrarhem Stigbergsliden")
    }

    @Test("Unsuccessfully fetching property details should set failure state", .tags(.viewModels))
    func onUnsuccessfulPropertyDetailsFetch() async throws {
        var repository: PropertiesRepository = .success
        repository.fetchPropertyDetails = { _ in
            throw NetworkingError.invalidResponse
        }

        let sut = PropertyListViewModel(
            initialState: .init(properties: [.mock]),
            repository: repository
        )

        sut.send(.onImageTap(.mock))

        // Give time for the async
        try await Task.sleep(for: .milliseconds(100))

        #expect(sut.destination == nil)
        #expect(sut.showAlertDetailsError == true)
    }

    @Test("Error alert ok button tapped should reset state", .tags(.viewModels))
    func onAlertOkButtonTapped() async throws {
        var repository: PropertiesRepository = .success
        repository.fetchPropertyDetails = { _ in
            throw NetworkingError.invalidResponse
        }

        let sut = PropertyListViewModel(
            initialState: .init(properties: [.mock]),
            repository: repository
        )

        sut.send(.onImageTap(.mock))

        // Give time for the async
        try await Task.sleep(for: .milliseconds(100))

        #expect(sut.destination == nil)
        #expect(sut.showAlertDetailsError == true)

        sut.send(.alertButtonOkTapped)

        #expect(sut.showAlertDetailsError == false)
        #expect(sut.fetchingDetails == .idle)
    }

    @Test("Sort properties by rating should sort correctly", .tags(.viewModels))
    func sortPropertiesByRating() async throws {
        let sut = PropertyListViewModel(
            initialState: .init(properties: [.mock, .mock2]),
            repository: .success
        )

        var firstProperty = try #require(sut.properties.first)
        var firstPropertyRating = try #require(firstProperty.overallRating.overall)
        #expect(firstPropertyRating == 82)

        var secondProperty = try #require(sut.properties.dropFirst().first)
        var secondPropertyRating = try #require(secondProperty.overallRating.overall)
        #expect(secondPropertyRating == 93)

        sut.send(.sortByRatingButtonTapped)

        firstProperty = try #require(sut.properties.first)
        firstPropertyRating = try #require(firstProperty.overallRating.overall)
        #expect(firstPropertyRating == 93)

        secondProperty = try #require(sut.properties.dropFirst().first)
        secondPropertyRating = try #require(secondProperty.overallRating.overall)
        #expect(secondPropertyRating == 82)
    }

    @Test("Sort properties by type should sort correctly", .tags(.viewModels))
    func sortPropertiesByType() async throws {
        let sut = PropertyListViewModel(
            initialState: .init(properties: [.mock, .mock2]),
            repository: .success
        )

        var firstProperty = try #require(sut.properties.first)
        #expect(firstProperty.type == "Hostel")

        var secondProperty = try #require(sut.properties.dropFirst().first)
        #expect(secondProperty.type == "Apartment")

        sut.send(.sortByTypeButtonTapped)

        firstProperty = try #require(sut.properties.first)
        #expect(firstProperty.type == "Apartment")

        secondProperty = try #require(sut.properties.dropFirst().first)
        #expect(secondProperty.type == "Hostel")
    }
}
