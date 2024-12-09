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
        case onAppear
        case onImageTap(Property)
        case retryButtonTapped
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
        case .onAppear:
            fetchProperties()

        case .onImageTap(let property):
            handlePropertySelection(property)

        case .retryButtonTapped:
            fetchProperties()
        }
    }

    // MARK: - Binding helper

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
                state.fetchingDetails = .failed(error)
            }
        }
    }
}

extension PropertyListViewModel {
    subscript<T>(dynamicMember keyPath: KeyPath<State, T>) -> T {
        get { state[keyPath: keyPath] }
    }
}
