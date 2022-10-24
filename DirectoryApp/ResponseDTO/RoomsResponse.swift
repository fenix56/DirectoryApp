//
//  RoomsResponse.swift
//  DirectoryApp
//
//  Created by Przemek on 21/10/2022.
//

import Foundation

// MARK: - RoomsResponse
struct RoomsResponse: Decodable {
    let createdAt: String
    let isOccupied: Bool
    let maxOccupancy: Int
    let id: String
}

typealias Rooms = [RoomsResponse]

extension Rooms {
    func toEntity() -> [Room] {
        return self.map {
            .init(roomId: $0.id, createdAt: $0.createdAt,
                  isOccupied: $0.isOccupied, maxOccupancy: $0.maxOccupancy)
        }
    }
}
