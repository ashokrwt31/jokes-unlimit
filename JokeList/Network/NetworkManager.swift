//
//  NetworkManager.swift
//  JokeList
//
//  Created by Ashok Rawat on 08/06/23.
//

import Foundation

protocol NetworkService {
    func executeRequest<T: Decodable>(url: URL, modelType: T.Type, completion: ((T?, Error? ) -> Void)?)
}

struct NetworkManager {
    private var httpMethod: String
    private var param: [String: Any]?
    init(httpMethod: HTTPMethod = .GET, _ param: [String: Any] = [String: Any]()) {
        self.httpMethod = httpMethod.rawValue
        self.param = param
    }
    
    private func createRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.networkServiceType = .default
        request.cachePolicy = .reloadRevalidatingCacheData
        request.timeoutInterval = 100
        request.httpShouldHandleCookies = true
        request.httpShouldUsePipelining = false
        request.allowsCellularAccess = true
        if let param = param, param.keys.count > 0 {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: param, options: [])
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        return request
    }
}

// MARK: - NetworkManager extension

extension NetworkManager: NetworkService {
    
    func executeRequest<T: Decodable>(url: URL, modelType: T.Type, completion: ((T?, Error? ) -> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: self.createRequest(url), completionHandler: { (data, response, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                    completion?(decodedResponse, nil)
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        })
        dataTask.resume()
    }
}
