//
//  ChallengeServiceTests.swift
//  AxxessChallengeTests
//
//  Created by Rahul Rachamalla on 3/31/21.
//

import XCTest
@testable import AxxessChallenge

class testChallengeService: XCTestCase {
    func testServiceResponse() throws {
        let expectation = XCTestExpectation(description: "Service should fetch challenge data")
        ChallengeService.shared.getData { data in
            XCTAssertNotNil(data)
            expectation.fulfill()
        } failure: { error in
            XCTFail("Service response failure")
        }
        
        wait(for: [expectation], timeout: 6.0)
    }

    func testServicePerformance() throws {
        self.measure {
            ChallengeService.shared.getData { _ in
            } failure: { _ in
            }
        }
    }

}
