//
//  ArticlesModel.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 06/07/24.
//

import Foundation

struct Articles: Codable {
    let articles: [Article]
    let status: String
    let message: String
    let totalResults: Int
    
    init(articles: [Article],status: String,message: String,totalResults: Int ){
        self.articles = articles
        self.status = status
        self.message = message
        self.totalResults = totalResults
    }
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case message = "message"
        case articles = "articles"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try values.decodeIfPresent(String.self, forKey: .status) ?? "error"
        self.message = try values.decodeIfPresent(String.self, forKey: .message) ?? ""
        self.totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
        self.articles = try values.decodeIfPresent([Article].self, forKey: .articles) ?? [Article]()
    }
}

struct Article: Codable {
    let source: Source?
    let title: String?
    let url: String?
    let urlToImage: String?
    let articleDescription: String?
    let publishedAt: String?
    let name: String?
    var toShow: Bool?
    
    init(source: Source?,title: String?,url: String?,urlToImage: String?,articleDescription: String?,publishedAt: String?,name: String?,toShow: Bool?){
        self.source = source
        self.title = title
        self.urlToImage = urlToImage
        self.url = url
        self.articleDescription = articleDescription
        self.publishedAt = publishedAt
        self.name = name
        self.toShow = toShow
    }
    private enum CodingKeys: String, CodingKey {
        case title
        case url
        case urlToImage
        case source
        case articleDescription = "description"
        case publishedAt
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String?.self, forKey: .title)
        self.url = try container.decode(String?.self, forKey: .url)
        self.urlToImage = try container.decode(String?.self, forKey: .urlToImage)
        self.articleDescription = try container.decode(String?.self, forKey: .articleDescription)
        self.publishedAt = try container.decode(String?.self, forKey: .publishedAt)

        self.source = try container.decodeIfPresent(Source.self, forKey: .source) ?? Source(from: decoder)
        self.name = self.source?.name
        self.toShow = true
    }
    
    func convertPublishTimeToString()-> String {
        return self.publishedAt?.toDate()?.displayStringFromDate() ?? ""
    }

}

struct Source: Codable {
    let id: String
    let name: String
    
    init(id: String,name: String){
        self.id = id
        self.name = name
    }
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
    }
}


