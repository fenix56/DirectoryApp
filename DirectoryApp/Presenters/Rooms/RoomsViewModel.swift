//
//  RoomsViewModel.swift
//  DirectoryApp
//
//  Created by Przemek on 24/10/2022.
//

import Foundation
import Combine

protocol RoomsViewModelInput {
    func getRooms(apiRequest: ApiRequestType)
}

protocol RoomsViewModelOutput {
    var getRoomsCount: Int {get}
    func getRoom(for index: Int) -> Room
}

class RoomsViewModel {
    private let networkManager: Networkable
    private var rooms: [Room] = []
    
    @Published var state: ViewState = .none
    
    init(networkManager: Networkable = NetworkManager()) {
        self.networkManager = networkManager
    }
}

extension RoomsViewModel: RoomsViewModelInput {
    func getRooms(apiRequest: ApiRequestType) {
        state = ViewState.loading
        self.networkManager.get(apiRequest: apiRequest, type: Rooms.self) {[weak self] result in
            switch result {
            case .success(let data):
                self?.rooms = data.toEntity()
                self?.state = ViewState.finishedLoading
            case .failure(let error):
                self?.state = ViewState.error(error.localizedDescription)
            }
        }
    }
}

extension RoomsViewModel: RoomsViewModelOutput {
    var getRoomsCount: Int {
        return rooms.count
    }
    
    func getRoom(for index: Int) -> Room {
        return rooms[index]
    }
}
