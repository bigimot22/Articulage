//
//  ArtEndPoint.swift
//  Articulage
//
//  Created by Johandre Delgado on 29.03.2022.
//

import Foundation
import ArtNetwork

struct ArtEndPoint: EndPoint {
  var path: String
  var queryItems: [URLQueryItem] = []
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

extension ArtEndPoint {
  static var artworks: Self {
    ArtEndPoint(path: "/artworks")
  }
  
  static func artwork(id: String) -> Self {
    ArtEndPoint(path: "/artworks/\(id)")
  }
}
