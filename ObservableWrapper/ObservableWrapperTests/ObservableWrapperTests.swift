//
//  ObservableWrapperTests.swift
//  ObservableWrapperTests
//
//  Created by 周正飞 on 2020/1/3.
//  Copyright © 2020 周正飞. All rights reserved.
//

import XCTest
@testable import MemoryCacheStorer

class ObservableWrapperTests: XCTestCase {
    
    struct MemoryCacheStorer {
        static let name = CacheStorer<String>()
        static let userHeight = CacheStorer<Int>()
    }
    
    class User {
        @MemoryObservableValue(storer: MemoryCacheStorer.name)
        var name: String = ""
        init() { }
    }
    
    func testSameInstanceChange() {
        let expection = XCTestExpectation()
        let user = User()
        user.$name.setObserverKey("1")
        user.$name.addObserver(self) { (newName) in
            XCTAssert(newName == "zzf")
            expection.fulfill()
        }
        user.name = "zzf"
        wait(for: [expection], timeout: 1)
    }
    
    func testDifferentInstanceChange() {
        let expection = XCTestExpectation()
        let user1 = User()
        user1.$name.setObserverKey("1")
        let user2 = User()
        user2.$name.setObserverKey("1")
        user2.$name.addObserver(self) { (newName) in
            XCTAssert(newName == "zzf")
            expection.fulfill()
        }
        user1.name = "zzf"
        wait(for: [expection], timeout: 1)
    }
    
    func testDeduplicationOfSameObserver() {
        let expection = XCTestExpectation()
        let user = User()
        user.$name.setObserverKey("1")
        user.$name.addObserver(self) { (newName) in
            assertionFailure("第一次注册的需要被覆盖")
        }
        user.$name.addObserver(self) { (newName) in
            assert(newName == "zzf")
            expection.fulfill()
        }
        user.name = "zzf"
        wait(for: [expection], timeout: 1)
    }
        
    func testMultipleObserver() {
        let expection1 = XCTestExpectation()
        let expection2 = XCTestExpectation()
        let user = User()
        user.$name.setObserverKey("1")
        user.$name.addObserver(self) { (newName) in
            XCTAssert(newName == "zzf")
            expection1.fulfill()
        }
        user.$name.addObserver(FileManager.default) { (newName) in
            XCTAssert(newName == "zzf")
            expection2.fulfill()
        }
        user.name = "zzf"
        wait(for: [expection1, expection2], timeout: 1)
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
