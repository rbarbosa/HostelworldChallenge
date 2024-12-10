//
//  PropertyDetailView.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 05/12/2024.
//

import SwiftUI

struct PropertyDetailView: View {

    let model: PropertyDetails

    var body: some View {
        NavigationStack {
            content()
                .padding(.bottom, 10)
                .navigationTitle(model.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(.hostelworldRed, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    // MARK: - Subviews

    private func content() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                photosCarousel()

                Text(model.type.capitalized)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                    .opacity(0.6)

                header()
                Divider()

                location()
                Divider()

                directions()
                Divider()

                about()

                if let detailRating = model.rating {
                    Divider()

                    detailedRating(detailRating)
                }
                Spacer()
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
        .padding(.top, 20)
    }

    private func photosCarousel() -> some View {
        VStack {
            TabView {
                ForEach(model.images, id: \.self) { image in
                    AsyncImage(url: URL(string: image)) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay {
                                    ProgressView()
                                }

                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()

                        case .failure:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay {
                                    Label("There was an error", systemImage: "exclamationmark.icloud")
                                }

                        @unknown default:
                            EmptyView()
                        }
                    }
                    // We need to set the height to apply the clip shape
                    .frame(height: 200)
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .tabViewStyle(.page)
        }
        .frame(height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private func header() -> some View {
        HStack(alignment: .lastTextBaseline) {
            Text(model.name)
                .bold()
                .font(.title2)
                .foregroundStyle(.primary)
                .opacity(0.9)

            Spacer()

            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)

            if let rating = model.rating {
                Text(
                    rating.averageRating(),
                    format: .number.precision(.fractionLength(1))
                )
                .bold()
                .font(.title3)
            } else {
                Text("N/A")
                    .font(.caption2)
            }
        }
    }

    private func location() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("\(model.city.name) - \(model.city.country)", systemImage: "mappin.and.ellipse")
                .bold()
                .font(.caption)
                .foregroundStyle(.primary)
                .opacity(0.8)

            Text(model.address1)
                .font(.caption2)

            if let address2 = model.address2 {
                Text(address2)
                    .font(.caption2)
            }
        }
    }

    private func directions() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Directions", systemImage: "arrow.trianglehead.turn.up.right.diamond")
                .bold()
                .font(.caption)
                .foregroundStyle(.primary)
                .opacity(0.8)

            Text(model.directions)
                .font(.caption)
                .foregroundStyle(.primary)
                .opacity(0.6)
        }
    }

    private func about() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About")
                .bold()
                .font(.title3)
                .foregroundStyle(.primary)
                .opacity(0.8)

            Text(model.description)
                .font(.caption)
                .lineSpacing(4)
                .foregroundStyle(.primary)
                .opacity(0.6)
        }
    }

    @ViewBuilder
    private func detailedRating(_ rating: DetailedRating) -> some View {
        VStack(alignment: .leading) {
            Text("Rating")
                .bold()
                .font(.title3)
                .foregroundStyle(.primary)
                .opacity(0.8)

            ForEach(DetailedRating.Category.allCases, id: \.self) { category in
                HStack(spacing: 16.0) {
                    Text(category.displayText)
                        .font(.subheadline)
                        .opacity(0.8)
                        .frame(width: 120, alignment: .leading)

                    Gauge(value: Double(rating.value(for: category) / 10), in: 0...10) { }
                        .tint(.hostelworldYellow)

                    Text(
                        rating.value(for: category) / 10,
                        format: .number.precision(.fractionLength(1))
                    )
                    .bold()
                    .opacity(0.8)
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    PropertyDetailView(model: .mock)
}
