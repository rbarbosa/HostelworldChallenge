//
//  HostelworldChallengeApp.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 04/12/2024.
//

import SwiftUI

@main
struct HostelworldChallengeApp: App {

    init () {
        loadRocketSimConnect()
    }

    var body: some Scene {
        WindowGroup {
            PropertyListView(viewModel: .init(initialState: .init(properties: []), repository: .live))
        }
    }
}

private func loadRocketSimConnect() {
#if DEBUG
    guard (Bundle(path: "/Applications/RocketSim.app/Contents/Frameworks/RocketSimConnectLinker.nocache.framework")?.load() == true) else {
        print("Failed to load linker framework")
        return
    }
    print("RocketSim Connect successfully linked")
#endif
}
