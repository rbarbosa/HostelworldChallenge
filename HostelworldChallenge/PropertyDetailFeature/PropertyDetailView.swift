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
                .navigationTitle(model.name)
                .navigationBarTitleDisplayMode(.inline)
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

                Spacer()
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
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

                        case .failure(let error):
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

            Text(
                model.rating.averageRating(),
                format: .number.precision(.fractionLength(1))
            )
            .bold()
            .font(.title3)
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
//                .lineLimit(3)
                .font(.caption)
                .lineSpacing(4)
                .foregroundStyle(.primary)
                .opacity(0.6)
        }
    }
}

// MARK: - Previews

#Preview {
    PropertyDetailView(model: .mock)
}
