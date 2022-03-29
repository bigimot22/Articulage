//
//  RequestTypes.swift
//  
//
//  Created by Johandre Delgado on 28.03.2022.
//

import Foundation

public enum RequestMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

public enum RequestError: Error {
  case invalidURL
  case responseError
  case unexpectedStatusCode
  case decodingError
  case unknown
  
  public var message: String {
    switch self {
    case .invalidURL:
      return "👀 Invalid URL"
    case .responseError:
      return "👀 Response error"
    case .unexpectedStatusCode:
      return "👀 Unexpected Response Code"
    case .decodingError:
      return "👀 Decoding error"
    default:
      return "👀 Unknow error"
    }
  }
}
