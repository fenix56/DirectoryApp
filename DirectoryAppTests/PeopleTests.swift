//
//  PeopleTests.swift
//  DirectoryAppTests
//
//  Created by Przemek on 24/10/2022.
//

import XCTest
@testable import DirectoryApp

final class PeopleTests: XCTestCase {

    var viewModel: PeopleViewModel!
    var networkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        networkManager = MockNetworkManager()
        viewModel = PeopleViewModel(networkManager: networkManager)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testGetPeople_success() {
        let peopleApiRequest = ApiRequest(baseUrl: EndPoint.baseURL, path: "people_success", params: [:])
        
        XCTAssertEqual(viewModel.state, .none)
        viewModel.getPeople(apiRequest: peopleApiRequest)
        
        XCTAssertEqual(viewModel.state, .finishedLoading)
        XCTAssertEqual(viewModel.getPeopleCount, 71)
        XCTAssertEqual(viewModel.getPerson(for: 0).personId, 1)
        XCTAssertEqual(viewModel.getPerson(for: 70).personId, 70)
    }

}
