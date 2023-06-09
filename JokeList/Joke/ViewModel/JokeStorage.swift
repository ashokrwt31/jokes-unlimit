//
//  JokeStorage.swift
//  JokeList
//
//  Created by Ashok Rawat on 09/06/23.
//

import Foundation

protocol JokeStorage {
    var jokes: [Joke] { get set }
}

struct UserDefaultsJokeStorage: JokeStorage {
    private let userDefaults = UserDefaults.standard
    
    private var _jokes: [Joke] = []
    
    var jokes: [Joke] {
        get {
            return loadJokesFromUserDefaults()
        }
        set {
            _jokes = newValue
            saveJokesToUserDefaults()
        }
    }
}

extension UserDefaultsJokeStorage {
    
    private func saveJokesToUserDefaults() {
        let propertyList = _jokes.map { $0.joke }
        userDefaults.set(propertyList, forKey: Constants.JOKE_KEY)
        userDefaults.synchronize()
    }
        
    private func loadJokesFromUserDefaults() -> [Joke] {
        if let encodedData = userDefaults.array(forKey: Constants.JOKE_KEY) {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: encodedData, options: .prettyPrinted)
                return try JSONDecoder().decode([Joke].self, from: jsonData)
            } catch {
                print("Error decoding jokes: \(error)")
            }
        }
        return []
    }
}
