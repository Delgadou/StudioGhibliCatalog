//
//  NetworkCall.swift
//  StudioGhibliCatalog
//
//  Created by Henrique Delgado on 03/02/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case noData
    case decodingError(String)
    case unknown(Error)

    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let code):
            return "HTTP error: \(code)"
        case .noData:
            return "No data received"
        case .decodingError(let message):
            return "Decoding failed: \(message)"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}

class NetworkService {
    func fetch<T: Decodable>(from urlString: String) async -> Result<T, NetworkError> {
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                return .failure(.httpError(statusCode: httpResponse.statusCode))
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return .success(decoded)
            } catch {
                let message = decodingErrorMessage(from: error)
                return .failure(.decodingError(message))
            }

        } catch {
            return .failure(.unknown(error))
        }
    }

    private func decodingErrorMessage(from error: Error) -> String {
        guard let decodingError = error as? DecodingError else {
            return error.localizedDescription
        }

        switch decodingError {
        case .keyNotFound(let key, let context):
            return "Missing key '\(key.stringValue)' - \(context.debugDescription)"
        case .valueNotFound(let type, let context):
            return "Missing value for '\(type)' - \(context.debugDescription)"
        case .typeMismatch(let type, let context):
            return "Type mismatch for '\(type)' - \(context.debugDescription)"
        case .dataCorrupted(let context):
            return "Data corrupted - \(context.debugDescription)"
        @unknown default:
            return "Unknown decoding error"
        }
    }

    func fetchMovies() async -> Result<[Movie], NetworkError> {
        await fetch(from: "https://ghibliapi.vercel.app/films")
    }
}
