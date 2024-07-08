//
//  SBHomePresenterTest.swift
//  iNewsTests
//
//  Created by Sanjay Bhanagade on 08/07/24.
//

@testable import iNews
import XCTest
import Foundation

class SBHomePresenterTest: XCTestCase {
    var objectTest: SBHomePresenter!
    override func setUp() {
        super.setUp()
        setupSearchPresenter()
    }
    
    func setupSearchPresenter() {
        objectTest = SBHomePresenter()
    }
}
