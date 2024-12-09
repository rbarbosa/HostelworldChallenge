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
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .navigationTitle("Gothenburg")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(.hostelworldRed, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationDestination(item: viewModel.destinationBinding(for: Destination.details)) { model in
                    PropertyDetailView(model: model)
                        .toolbarRole(.editor)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Button {
                                viewModel.send(.sortByRatingButtonTapped)
                            } label: {
                                Text("By rating")
                            }
                            Button {
                                viewModel.send(.sortByTypeButtonTapped)
                            } label: {
                                Text("By type")
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                    }
                }
        }
        .alert(
            "Error",
            isPresented: viewModel.binding(\.showAlertDetailsError),
            actions: {
                Button("OK") {
                    viewModel.send(.alertButtonOkTapped)
                }
            },
            message: {
                Text("There was an error getting property details. Please try again.")
            }
        )
        .onAppear {
            viewModel.send(.onAppear)
        }
    }

    @ViewBuilder
    private func content() -> some View {
        switch viewModel.fetching {
        case .loading:
            VStack {
                propertyCard(viewModel.emptyProperty)

                Spacer()
            }
            .redacted(reason: .placeholder)

        case .failed:
            VStack {
                Text("Something went wrong...")
                    .font(.title3)
                    .opacity(0.7)

                retryButton()
            }

        case .idle:
            propertyList()
                .opacity(viewModel.isFetchingDetails ? 0.5 : 1.0)
                .padding(.bottom, 10)
                .overlay {
                    if viewModel.isFetchingDetails {
                        ProgressView()
                            .padding()
                            .background(.primary.opacity(0.25))
                            .controlSize(.extraLarge)
                            .tint(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 6.0))
                    }
                }
        }
    }

    private func propertyList() -> some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.properties) { property in

                    propertyCard(property)
                        .padding(.bottom, 10)

                    Divider()
                }
            }
        }
        .scrollIndicators(.hidden)
    }

    private func propertyCard(_ property: Property) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            image(for: property)

            Text(property.name)
                .font(.headline)
                .opacity(0.7)
                .padding(.top, 16)

            rating(for: property)
                .padding(.top, 8)

            Text(property.type.capitalized)
                .font(.caption)
                .opacity(0.7)
                .padding(.top, 8)
        }
    }

    private func image(for property: Property) -> some View {
        AsyncImage(url: URL(string: property.images.first ?? "")) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay {
                        if case .idle = viewModel.fetching {
                            ProgressView()
                        }
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
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }

    private func rating(for property: Property) -> some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)

            if let overall = property.overallRating.overall {
                Text(
                    Double(overall / 10),
                    format: .number.precision(.fractionLength(1))
                )
                .fontWeight(.semibold)
                .opacity(0.8)
            } else {
                Text("NA")
                    .font(.caption)
            }

            if let _ = property.overallRating.overall {
                Text("(\(property.overallRating.numberOfRatings))")
                    .font(.caption)
                    .opacity(0.6)
            }
        }
    }

    private func retryButton() -> some View {
        Button {
            viewModel.send(.retryButtonTapped)
        } label: {
            Text("Retry")
                .padding(.vertical, 4)
                .padding(.horizontal, 30)
        }
        .buttonStyle(.borderedProminent)
        .tint(.hostelworldYellow)
    }
}

// MARK: - Previews

#Preview("Success") {
    PropertyListView(
        viewModel: .init(
            initialState: .init(),
            repository: .live
        )
    )
}

#Preview("Error details") {
    var repository: PropertiesRepository = .success
    repository.fetchPropertyDetails = { _ in throw NetworkingError.invalidResponse }

   return PropertyListView(
        viewModel: .init(
            initialState: .init(),
            repository: repository
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

#Preview("Failure") {
    PropertyListView(
        viewModel: .init(
            initialState: .init(),
            repository: .failure
        )
    )
}
