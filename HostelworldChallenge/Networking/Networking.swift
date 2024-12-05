//
//  Networking.swift
//  HostelworldChallenge
//
//  Created by Rui Barbosa on 05/12/2024.
//

import Foundation

enum NetworkingError: Error {
    case decodingFailed(Error)
    case invalidResponse
    case invalidURL
    case requestFailed(Error)
}

// Properties
// https://private-anon-a79d5f524a-practical3.apiary-mock.com/cities/1530/properties/

// Property
// https://private-anon-a79d5f524a-practical3.apiary-mock.com/properties/32849

final class Networking {

    private enum APIURLComponents {
        static let scheme = "https"
        static let host = "private-anon-a79d5f524a-practical3.apiary-mock.com"
        static let path = "/v1/"
    }

    func fetch(query: QueryType) async throws -> Data {
        guard let url = makeURL(fromQuery: query) else {
            throw NetworkingError.invalidURL
        }

        let urlRequest = URLRequest(url: url)

        return try await performURLRequest(urlRequest)

    }

    private func performURLRequest(_ urlRequest: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard
                let httpResponse = response as? HTTPURLResponse,
                200..<300 ~= httpResponse.statusCode
            else {
                throw NetworkingError.invalidResponse
            }

            return data
        } catch {
            throw NetworkingError.requestFailed(error)
        }
    }

    private func makeURL(fromQuery queryType: QueryType) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = APIURLComponents.scheme
        urlComponents.host = APIURLComponents.host
        urlComponents.path = APIURLComponents.path + queryType.path

        return urlComponents.url
    }
}
