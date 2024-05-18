//
//  ContentViewUITests.swift
//  CatsAppUITests
//
//  Created by Juan Ernesto Crawford Naranjo on 17/5/24.
//

import XCTest
import SwiftUI
import ViewInspector
import Combine
@testable import CatsApp

/// Tests for the ContentView view.
class ContentViewTests: XCTestCase {
    
    /// Set to hold cancellable objects.
    private var cancellables = Set<AnyCancellable>()
    
    /// Test case for the loading state of ContentView.
    func testContentViewLoadingState() throws {
        let contentView = ContentView()
        ViewHosting.host(view: contentView)
        let text = try contentView.inspect().find(text: "Loading ...")
        XCTAssertNotNil(text)
    }
    
    /// Test case for verifying that cats are loaded in ContentView.
    func testContentViewCatsLoaded() throws {
        let expectation = XCTestExpectation(description: "Wait for cats to load")
        let networkManager = NetworkManager()
        let contentView = ContentView(networkManager: networkManager)
        networkManager.$cats
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }.store(in: &cancellables)
        ViewHosting.host(view: contentView)
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNoThrow(try contentView.inspect().find(ViewType.List.self))
        let navLink = try contentView.inspect().find(ViewType.NavigationLink.self)
        XCTAssertNotNil(navLink)
    }
}

