//
//  PeopleViewModel.swift
//  DirectoryApp
//
//  Created by Przemek on 21/10/2022.
//

import Foundation
import Combine

enum ViewState: Equatable {
    case none
    case loading
    case finishedLoading
    case error(String)
}

protocol PeopleViewModelInput {
    func getPeople(apiRequest: ApiRequestType)
}

protocol PeopleViewModelOutput {
    var getPeopleCount: Int {get}
    func getPerson(for index: Int) -> Person
}

class PeopleViewModel {
    private let networkManager: Networkable
    private var people: [Person] = []
    
    @Published var state: ViewState = .none
    
    init(networkManager: Networkable = NetworkManager()) {
        self.networkManager = networkManager
    }
}

extension PeopleViewModel: PeopleViewModelInput {
    func getPeople(apiRequest: ApiRequestType) {
        state = ViewState.loading
        self.networkManager.get(apiRequest: apiRequest, type: People.self) {[weak self] result in
            switch result {
            case .success(let data):
                self?.people = data.toEntity()
                self?.state = ViewState.finishedLoading
            case .failure(let error):
                self?.state = ViewState.error(error.localizedDescription)
            }
        }
    }
}

extension PeopleViewModel: PeopleViewModelOutput {
    var getPeopleCount: Int {
        return people.count
    }
    
    func getPerson(for index: Int) -> Person {
        return people[index]
    }
    
}
