//
//  Room.swift
//  DirectoryApp
//
//  Created by Przemek on 24/10/2022.
//

import Foundation

class Room {
    let roomId: String
    let createdAt: String
    let isOccupied: Bool
    let maxOccupancy: Int
    
    init(roomId: String, createdAt: String, isOccupied: Bool, maxOccupancy: Int) {
        self.roomId = roomId
        self.createdAt = createdAt
        self.isOccupied = isOccupied
        self.maxOccupancy = maxOccupancy
    }
}
