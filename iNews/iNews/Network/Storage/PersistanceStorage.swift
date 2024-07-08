//
//  PersistanceStorage.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 06/07/24.
//

import Foundation

public class PersistenceStorage {
    
    public static let shared = PersistenceStorage()
    
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let articlesKey = "Articles"
    
    func loadBookMarkedArticles() -> [Article]? {
        // Retrieving and decoding from UserDefaults
        if let savedData = userDefaults.data(forKey: articlesKey) {
            do {
                let decoder = JSONDecoder()
                let loadedArray = try decoder.decode([Article].self, from: savedData)
                print(" ")
                print("Decoded data:")
                print(" ")
                print(loadedArray)
                return loadedArray // Return the loaded data
            } catch {
                print("= =  = ")
                print(" ")
                print("Error decoding data: \(error)")
            }
        }
        return nil
    }
    
    func bookmarkArticles(_ articles: [Article]) {
        // Encoding and saving to UserDefaults
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encodedData = try? encoder.encode(articles) {
            userDefaults.set(encodedData, forKey: articlesKey)
        }
        
    }
}
