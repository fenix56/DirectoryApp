//
//  NetworkManager.swift
//  DirectoryApp
//
//  Created by Przemek on 21/10/2022.
//

import Foundation
typealias Completion<T> = (Result<T, ServiceError>) -> Void

protocol Networkable {
    func get<T: Decodable>(apiRequest: ApiRequestType, type: T.Type, completion: @escaping Completion<T>)
}

final class NetworkManager: Networkable {
    func get<T: Decodable>(apiRequest: ApiRequestType, type: T.Type, completion: @escaping Completion<T>) {
        guard let request = URLRequest.getURLRequest(for: apiRequest) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(ServiceError.dataNotFound))
                return
            }
            guard let unwrappedData = data, error == nil else {
                completion(.failure(ServiceError.dataNotFound))
                return
            }
            if T.self == Data.self, let unwrappedData = unwrappedData as? T {
                completion(.success(unwrappedData))
                return
            }
            do {
                let parsedData = try JSONDecoder().decode(T.self, from: unwrappedData)
                completion(.success(parsedData))
            } catch {
                completion(.failure(ServiceError.parsingError))
            }
        }).resume()
    }
}
