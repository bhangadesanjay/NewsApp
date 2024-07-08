//
//  ArticlesInjectable.swift
//  iNewsTests
//
//  Created by Sanjay Bhanagade on 08/07/24.
//
@testable import iNews
import Foundation
import XCTest

struct ArticlesInjectable{
    struct ArticlesTest {
        static let articleOne = Article(source: Source(id: "", name: ""), title: "articleOne", url: "https://google.com", urlToImage: "https://google.com", articleDescription: "article description", publishedAt: "", name: "", toShow: true)
        
        static let articleTwo = Article(source: Source(id: "", name: ""), title: "articleOne", url: "https://google.com", urlToImage: "https://google.com", articleDescription: "article description", publishedAt: "", name: "", toShow: true)
        
        static let articleThree = Article(source: Source(id: "", name: ""), title: "articleOne", url: "https://google.com", urlToImage: "https://google.com", articleDescription: "article description", publishedAt: "", name: "", toShow: true)
    }
}
