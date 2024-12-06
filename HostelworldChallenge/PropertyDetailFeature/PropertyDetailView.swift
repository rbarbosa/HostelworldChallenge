//
//  PropertyDetailView.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 05/12/2024.
//

import SwiftUI

struct PropertyDetailView: View {

    var body: some View {
        NavigationStack {
            content()
                .navigationTitle("STF Vandrarhem Stigbergsliden")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    // MARK: - Subviews
    private func content() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                photosCarousel()

                Text("Hostel")
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
        .padding(.horizontal)
    }

    private func photosCarousel() -> some View {
        Rectangle()
            .fill(Color.red).opacity(0.9)
            .frame(height: 200)
    }

    private func header() -> some View {
        HStack(alignment: .lastTextBaseline) {
            Text("STF Vandrarhem Stigbergsliden")
                .bold()
                .font(.title2)
                .foregroundStyle(.primary)
                .opacity(0.9)

            Spacer()

            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)

            Text("9.8")
                .bold()
                .font(.title3)
        }
    }

    private func location() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Gothenburg - Sweden", systemImage: "mappin.and.ellipse")
                .bold()
                .font(.caption)
                .foregroundStyle(.primary)
                .opacity(0.8)

            Text("Stigbergsliden 10")
                .font(.caption2)
        }
    }

    private func directions() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Directions", systemImage: "arrow.trianglehead.turn.up.right.diamond")
                .bold()
                .font(.caption)
                .foregroundStyle(.primary)
                .opacity(0.8)

            Text("Car: Drive towards 'centrum'. Follow the signs towards 'Fredrikshavn'. Chose exit 'Fiskhamnsmotet' and follow the sign to 'Majorna'. Turn left at the first traffic light to Karl Johansgatan and continue up the hill and down again, the street has now changed name to 'Stigbergsliden'. You find us on nr 10.")
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

            Text("Set in a listed building from the mid-1800s in the trendy area of Majorna/Linné. This traditional, eco-friendly hostel is a 12-minute tram ride from Gothenburg Central Station.")
                .lineLimit(3)
                .font(.caption)
                .lineSpacing(4)
                .foregroundStyle(.primary)
                .opacity(0.6)
        }
    }
}

// MARK: - Previews

#Preview {
    PropertyDetailView()
}
