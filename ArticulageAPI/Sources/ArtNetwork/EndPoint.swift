//
//  File.swift
//  
//
//  Created by Johandre Delgado on 28.03.2022.
//

import Foundation

public struct EndPoint {
  var path: String
  var queryItems: [URLQueryItem] = []
  var stringUrl: String {
    url.absoluteString
  }
  var url: URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.artic.edu"
    components.path = "/api/v1" + path
    components.queryItems = queryItems
    
    guard let url = components.url else {
      preconditionFailure("Invalid URL: \(components)")
    }
    return url
  }
}

public extension EndPoint {
  static var artworks: Self {
    EndPoint(path: "/artworks")
  }
  
  static func artwork(id: String) -> Self {
    EndPoint(path: "/artworks/\(id)")
  }
}
