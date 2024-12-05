//
//  PropertyListView.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 04/12/2024.
//

import SwiftUI

struct PropertyListView: View {

    let viewModel: PropertyListViewModel

    var body: some View {
        NavigationStack {
            content()
                .navigationTitle("Gothenburg")
                .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
    }

    private func content() -> some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.properties) { property in
                    propertyCard(property)
                        .padding(.horizontal, 10)
                }
            }
        }
    }

    private func propertyCard(_ property: Property) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundStyle(.gray)

            VStack(alignment: .leading) {
                Text(property.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .opacity(0.8)
                    .padding(.bottom, 5)

                Label("\(property.overallRating.overall)", systemImage: "star")
                    .padding(.bottom, 5)

                Text(property.type)
                    .font(.caption2)
                    .foregroundStyle(.primary)
                    .opacity(0.6)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Previews

#Preview {
    PropertyListView(
        viewModel: .init(
            initialState: .init(
                properties: []
            ),
            repository: .success
        )
    )
}
