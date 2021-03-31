//
//  ListViewModelTests.swift
//  AxxessChallengeTests
//
//  Created by Rahul Rachamalla on 3/31/21.
//

import XCTest
@testable import AxxessChallenge

class ListViewModelTests: XCTestCase {

    var listViewModel: ListViewModel!
    
    override func setUp() {
        super.setUp()
        let cd1 = ChallengeData(id: "1", type: "text", date: "12/12/2002", data: "test data 1")
        let cd2 = ChallengeData(id: "2", type: "image", date: "12/13/2002", data: "test data 2")
        let cd3 = ChallengeData(id: "3", type: "other", date: "12/14/2002", data: "test data 3")
        listViewModel = ListViewModel(viewState: .none, data: [cd1, cd2, cd3])
    }
    
    override func tearDown() {
        listViewModel = nil
        super.tearDown()
    }
    
    func testListViewBindings() {
        var viewState: ListViewModel.ViewState?
        listViewModel.viewStateBinding.bind {  viewState = $0 }
        XCTAssertNotNil(viewState)
        XCTAssertEqual(viewState!, ListViewModel.ViewState.none)
    }
    
    func testListSortAsc() {
        let sortedAscTypes = ["image", "other", "text"]
        listViewModel.sortData(isAscending: true)
        for i in 0..<sortedAscTypes.count {
            XCTAssert(sortedAscTypes[i] == listViewModel.challengeData[i].type)
        }
    }
    
    func testListSortDesc() {
        let sortedAscTypes = ["text", "other", "image"]
        listViewModel.sortData(isAscending: false)
        for i in 0..<sortedAscTypes.count {
            XCTAssert(sortedAscTypes[i] == listViewModel.challengeData[i].type)
        }
    }
    
    func testListSortedAsc() {
        let sortedAscTypes = ["image", "other", "text"]
        let sortedData = listViewModel.sortedData(data: listViewModel.challengeData, isAscending: true)
        for i in 0..<sortedData.count {
            XCTAssert(sortedData[i].type == sortedAscTypes[i])
        }
    }
    
    func testListSortedDesc() {
        let sortedAscTypes = ["text", "other", "image"]
        let sortedData = listViewModel.sortedData(data: listViewModel.challengeData, isAscending: false)
        for i in 0..<sortedData.count {
            XCTAssert(sortedData[i].type == sortedAscTypes[i])
        }
    }

}
