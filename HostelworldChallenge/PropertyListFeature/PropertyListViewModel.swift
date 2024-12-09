//
//  PropertyListViewModel.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 04/12/2024.
//

import Foundation
import struct SwiftUI.Binding

@dynamicMemberLookup
@Observable
final class PropertyListViewModel {

    // MARK: - Destination

    enum Destination {
        case details(PropertyDetails)
    }

    // MARK: - State

    struct State {
        enum Fetching {
            case idle
            case loading
            case failed(Error)
        }

        var destination: Destination?
        var fetching: Fetching = .idle
        var fetchingDetails: Fetching = .idle
        var showAlertDetailsError: Bool = false
        var isFetchingDetails: Bool {
            if case .loading = fetchingDetails {
                return true
            }

            return false
        }
        var properties: [Property] = []
        let emptyProperty: Property = .init(
            id: "",
            name: "Some random property",
            city: .init(id: "", name: "", country: ""),
            type: "Hostel",
            overallRating: .init(numberOfRatings: 4, overall: 80),
            images: []
        )
    }

    // MARK: - Action

    enum Action {
        case alertButtonOkTapped
        case onAppear
        case onImageTap(Property)
        case retryButtonTapped
        case sortByRatingButtonTapped
        case sortByTypeButtonTapped
    }

    // MARK: - Properties

    private(set) var state: State
    private let repository: PropertiesRepository

    // MARK: - Initialization

    init(
        initialState: State,
        repository: PropertiesRepository
    ) {
        self.state = initialState
        self.repository = repository
    }

    func send(_ action: Action) {
        switch action {
        case .alertButtonOkTapped:
            state.fetchingDetails = .idle
            state.showAlertDetailsError = false

        case .onAppear:
            fetchProperties()

        case .onImageTap(let property):
            handlePropertySelection(property)

        case .retryButtonTapped:
            fetchProperties()

        case .sortByRatingButtonTapped:
            sortPropertiesByRating()

        case .sortByTypeButtonTapped:
            sortPropertiesByType()
        }
    }

    // MARK: - Binding helpers

    func destinationBinding<T>(
        for destinationType: @escaping (T) -> Destination
    ) -> Binding<T?> {
        Binding(
            get: {
                switch self.state.destination {
                case .details(let model):
                    return model as? T

                case .none:
                    return nil
                }
            },
            set: { [weak self] newValue in
                guard let self else { return }
                self.state.destination = newValue.map(destinationType)
            }
        )
    }

    func binding<T>(_ keyPath: WritableKeyPath<State, T>) -> Binding<T> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }

    // MARK: - Private methods

    private func fetchProperties() {
        state.fetching = .loading

        Task { @MainActor in

            do {
                let response = try await repository.fetchCityProperties("1530")
                state.properties = response.properties
                state.fetching = .idle
            } catch {
                state.fetching = .failed(error)
            }
        }
    }

    private func handlePropertySelection(_ property: Property) {
        state.fetchingDetails = .loading

        Task { @MainActor in
            do {
                let propertyDetails = try await repository.fetchPropertyDetails(property.id)
                state.destination = .details(propertyDetails)
                state.fetchingDetails = .idle
            } catch {
                state.showAlertDetailsError = true
            }
        }
    }

    private func sortPropertiesByRating() {
        let sortedProperties = state.properties.sorted {
            $0.overallRating.overall ?? 0 > $1.overallRating.overall ?? 0
        }
        state.properties = sortedProperties
    }

    private func sortPropertiesByType() {
        let sortedProperties = state.properties.sorted {
            $0.type.localizedCaseInsensitiveCompare($1.type) == .orderedAscending
        }
        state.properties = sortedProperties
    }
}

extension PropertyListViewModel {
    subscript<T>(dynamicMember keyPath: KeyPath<State, T>) -> T {
        get { state[keyPath: keyPath] }
    }
}
