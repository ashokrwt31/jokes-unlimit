//
//  NetworkError.swift
//  JokeList
//
//  Created by Ashok Rawat on 08/06/23.
//


// MARK: - Network Error

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

// MARK: - Request type

public enum HTTPMethod: String {
    case GET
    
    var method: String { rawValue.uppercased() }
}
