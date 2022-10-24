//
//  MockNetworkManager.swift
//  DirectoryAppTests
//
//  Created by Przemek on 24/10/2022.
//

import Foundation
@testable import DirectoryApp

class MockNetworkManager: Networkable {
    func get<T>(apiRequest: DirectoryApp.ApiRequestType, type: T.Type, completion: @escaping DirectoryApp.Completion<T>) where T: Decodable {
        let bundle = Bundle(for: MockNetworkManager.self)
        
        guard let url = bundle.url(forResource: apiRequest.path, withExtension: "json"), let data = try? Data(contentsOf: url) else {
            completion(.failure(ServiceError.dataNotFound))
            return
        }
        
        do {
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(parsedData))
        } catch {
            completion(.failure(ServiceError.parsingError))
        }
    }
}
