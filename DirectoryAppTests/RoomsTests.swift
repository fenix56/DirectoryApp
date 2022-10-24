//
//  RoomsTests.swift
//  DirectoryAppTests
//
//  Created by Przemek on 24/10/2022.
//

import XCTest
@testable import DirectoryApp

final class RoomsTests: XCTestCase {

    var viewModel: RoomsViewModel!
    var networkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        networkManager = MockNetworkManager()
        viewModel = RoomsViewModel(networkManager: networkManager)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testGetRooms_success() {
        let roomsApiRequest = ApiRequest(baseUrl: EndPoint.baseURL, path: "rooms_success", params: [:])
        
        XCTAssertEqual(viewModel.state, .none)
        viewModel.getRooms(apiRequest: roomsApiRequest)
        
        XCTAssertEqual(viewModel.state, .finishedLoading)
        XCTAssertEqual(viewModel.getRoomsCount, 65)
        XCTAssertEqual(viewModel.getRoom(for: 0).isOccupied, false)
        XCTAssertEqual(viewModel.getRoom(for: viewModel.getRoomsCount - 1).isOccupied, true)
    }
    
    func testGetRooms_failure() {
        let roomsApiRequest = ApiRequest(baseUrl: EndPoint.baseURL, path: "rooms_failure", params: [:])
        
        XCTAssertEqual(viewModel.state, .none)
        viewModel.getRooms(apiRequest: roomsApiRequest)
        
        XCTAssertEqual(viewModel.state, .error(ServiceError.dataNotFound.localizedDescription))
        XCTAssertEqual(viewModel.getRoomsCount, 0)
    }

}
