//
//  PropertyListView.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 04/12/2024.
//

import SwiftUI

struct PropertyListView: View {

    let viewModel: PropertyListViewModel

    typealias Destination = PropertyListViewModel.Destination

    var body: some View {
        NavigationStack {
            content()
                .navigationTitle("Gothenburg")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(item: viewModel.destinationBinding(for: Destination.details)) { model in
                    PropertyDetailView(model: model)
                        .toolbarRole(.editor)
                }
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
    }

    @ViewBuilder
    private func content() -> some View {
        if viewModel.isLoading {
            VStack {
                propertyCard(viewModel.emptyProperty)

                Spacer()
            }
            .padding(.horizontal, 10)
            .redacted(reason: .placeholder)
        } else {
            propertyList()
                .padding(.bottom, 10)
        }
    }

    private func propertyList() -> some View {
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
            AsyncImage(url: URL(string: property.images.first ?? "")) { phase in
                switch phase {
                case .empty:
                    if viewModel.isLoading {
                        Color.gray
                            .opacity(0.4)
                    } else {
                        ProgressView()
                    }

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .onTapGesture {
                            viewModel.send(.onImageTap(property))
                        }

                case .failure(let error):
                    Label("There was an error", systemImage: "exclamationmark.icloud")

                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 6))

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

#Preview("Success") {
    PropertyListView(
        viewModel: .init(
            initialState: .init(),
            repository: .success
        )
    )
}

#Preview("Long loading") {
    PropertyListView(
        viewModel: .init(
            initialState: .init(),
            repository: .shortLoading
        )
    )
}
