//
//  HostelworldChallengeApp.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 04/12/2024.
//

import SwiftUI

@main
struct AppLauncher {
    static func main() {
        if NSClassFromString("XCTestCase") != nil {
            TestApp.main()
        } else {
            HostelworldChallengeApp.main()
        }
    }
}

struct HostelworldChallengeApp: App {

    init () {
        loadRocketSimConnect()
    }

    var body: some Scene {
        WindowGroup {
            PropertyListView(
                viewModel: .init(
                    initialState: .init(),
                    repository: .live
                )
            )
        }
    }
}

// MARK: - TestView

struct TestApp: App {
    var body: some Scene {
        WindowGroup {
            Text("Running Unit Tests!")
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
