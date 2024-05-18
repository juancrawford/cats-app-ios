//
//  DetailViewUITests.swift
//  CatsAppUITests
//
//  Created by Juan Ernesto Crawford Naranjo on 17/5/24.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import CatsApp

/// Tests for the DetailView view.
class DetailViewUITests: XCTestCase {
    
    /// Test case to verify if the DetailView displays the description title.
    func testDetailViewDisplaysDescriptionTitle() throws {
        let view = DetailView(cat: catMock)
        let title = try view.inspect().scrollView().vStack().hStack(1).text(0).string()
        XCTAssertEqual(title, "Description")
    }
    
    /// Test case to verify if the DetailView displays the cat description.
    func testDetailViewDisplaysCatDescription() throws {
        let view = DetailView(cat: catMock)
        let description = try view.inspect().scrollView().vStack().text(2).string()
        XCTAssertEqual(description, catMock.breeds.first?.description)
    }
}
