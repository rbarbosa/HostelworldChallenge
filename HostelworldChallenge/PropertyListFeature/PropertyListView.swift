//
//  PropertyListView.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 04/12/2024.
//

import SwiftUI

struct PropertyListView: View {

    var body: some View {
        NavigationStack {
            content()
                .navigationTitle("Gothenburg")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func content() -> some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(0..<3) { _ in
                    propertyCard()
                        .padding(.horizontal, 10)
                }
            }
        }
    }

    private func propertyCard() -> some View {
        HStack(alignment: .top, spacing: 10) {
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundStyle(.gray)

            VStack(alignment: .leading) {
                Text("STF Vandrarhem Stigbergsliden")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .opacity(0.8)
                    .padding(.bottom, 5)

                Label("82", systemImage: "star")
                    .padding(.bottom, 5)

                Text("Hostel")
                    .font(.caption2)
                    .foregroundStyle(.primary)
                    .opacity(0.6)
            }
        }
    }
}

// MARK: - Previews

#Preview {
    PropertyListView()
}
