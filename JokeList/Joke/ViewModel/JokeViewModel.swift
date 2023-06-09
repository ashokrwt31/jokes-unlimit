//
//  JokeViewModel.swift
//  JokeList
//
//  Created by Ashok Rawat on 08/06/23.
//

import Foundation

typealias JokeCompletionClosure = (([Joke]?, Error?) -> Void)

protocol JokeListService {
    func fetchJokes(completion: @escaping JokeCompletionClosure)
}

class JokeViewModel: JokeListService {
    
    private let networkService: NetworkService
    private var jokeStorage: JokeStorage
    
    init(networkService: NetworkService, jokeStorage: JokeStorage) {
        self.networkService = networkService
        self.jokeStorage = jokeStorage
    }
    
    // MARK: - API Call
    
    func fetchJokes(completion: @escaping JokeCompletionClosure) {
        guard let url =  URL(string: Constants.API.baseURL) else {
            completion(nil, NetworkError.invalidUrl)
            return
        }
        networkService.executeRequest(url: url, modelType: Joke.self) {[weak self]  (data, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            self?.addJoke(data)
            completion(self?.jokeStorage.jokes, nil)
        }
    }
    
    private func addJoke(_ joke: Joke) {
        var jokes = jokeStorage.jokes
        jokes.append(joke)
        if jokes.count > 10 {
            jokes.removeFirst(jokes.count - 10)
        }
        self.jokeStorage.jokes = jokes
    }
}
