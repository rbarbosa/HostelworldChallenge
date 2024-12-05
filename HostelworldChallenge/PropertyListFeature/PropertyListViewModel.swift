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

    // MARK: - Initialization

    init(initialState: State) {
        self.state = initialState
    }

    func send(_ action: Action) {
        switch action {
        case .onAppear:
            fetchProperties()
        }
    }

    // MARK: - Private methods
    private func fetchProperties() {
        state.properties = [.mock]
    }
}

extension PropertyListViewModel {
    subscript<T>(dynamicMember keyPath: KeyPath<State, T>) -> T {
        get { state[keyPath: keyPath] }
    }
}
