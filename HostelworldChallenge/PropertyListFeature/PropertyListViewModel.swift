//
//  PropertyListViewModel.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 04/12/2024.
//

import Foundation

@dynamicMemberLookup
@Observable
final class PropertyListViewModel {

    // MARK: - Destination

    enum Destination {
    }

    // MARK: - State

    struct State {
        var properties: [Property]
    }

    // MARK: - Action

    enum Action {
        case onAppear
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
        }
    }

    // MARK: - Private methods

    private func fetchProperties() {
        Task { @MainActor in
            do {
                let response = try await repository.fetchCityProperties("1530")
                state.properties = response.properties
            } catch {
                print("Error fetching properties: \(error)")
            }
        }
    }
}

extension PropertyListViewModel {
    subscript<T>(dynamicMember keyPath: KeyPath<State, T>) -> T {
        get { state[keyPath: keyPath] }
    }
}
