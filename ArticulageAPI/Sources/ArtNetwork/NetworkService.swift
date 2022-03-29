//
//  NetworkService.swift
//  
//
//  Created by Johandre Delgado on 28.03.2022.
//

import Foundation

public protocol Networkable {
  func fetch<T: Decodable>(_ modelType: T.Type, from endpoint: EndPoint, completion: @escaping (Result<T, RequestError>) -> Void)
}

public final class NetworkService: Networkable {
  let session: URLSession
  
  public init(urlSession: URLSession = .shared) {
    self.session = urlSession
  }
  
  public func fetch<T: Decodable>(_ modelType: T.Type, from endpoint: EndPoint, completion: @escaping (Result<T, RequestError>) -> Void) {
    let method = RequestMethod.get
    var request = URLRequest(url: endpoint.url)
    request.httpMethod = method.rawValue
    
    
    let task = session.dataTask(with: request) { data, response, error in
      if let _ = error {
        completion(.failure(.unknown))
      }
      
      guard let response = response as? HTTPURLResponse else {
        return completion(.failure(.responseError))
      }
      if !(200...299).contains(response.statusCode) {
        completion(.failure(.responseError))
      }
      
      if let data = data {
        do {
          let decodedModel = try JSONDecoder().decode(T.self, from: data)
          DispatchQueue.main.async {
            completion(.success(decodedModel))
          }
        }
        catch {
          completion(.failure(.decodingError))
        }
      }
    }
    task.resume()
  }
}


