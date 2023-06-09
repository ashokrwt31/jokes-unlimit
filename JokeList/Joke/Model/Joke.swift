//
//  Joke.swift
//  JokeList
//
//  Created by Ashok Rawat on 08/06/23.
//

struct Joke: Codable {
    let joke: String
    
    enum CodingKeys: String, CodingKey {
        case joke
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        joke = try container.decode(String.self)
    }
}
