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

        #expect(sut.state.isFetchingDetails == false)
        #expect(sut.state.destination == nil)
        #expect(sut.state.showAlertDetailsError == false)
    }
}
