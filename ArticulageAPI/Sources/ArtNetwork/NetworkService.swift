//
//  NetworkService.swift
//  
//
//  Created by Johandre Delgado on 28.03.2022.
//

import Foundation

@inlinable func log(_ text: String, terminator: String? = nil) {
    #if DEBUG
        terminator == nil ? print(text) : print(text, terminator: terminator!)
    #endif
}

func log(_ objects: Any...) -> () {
    #if DEBUG
        log(objects.map{"\($0)"}.joined(separator: " "))
    #endif
}




public protocol Networkable {
  func fetchSample() -> Void
  func fetch<T: Decodable>(_ modelType: T.Type, from endpoint: EndPoint, completion: @escaping (Result<T, RequestError>) -> Void)
}

public final class NetworkService: Networkable {
  let session: URLSession
  
  public init(urlSession: URLSession = .shared) {
          self.session = urlSession
      }
  
  public func fetchSample() {
    print("👀 fetched items", Date())
  }
  
  public func fetch<T: Decodable>(_ modelType: T.Type, from endpoint: EndPoint, completion: @escaping (Result<T, RequestError>) -> Void) {
    log("EndPoint URL:", endpoint.url)
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

