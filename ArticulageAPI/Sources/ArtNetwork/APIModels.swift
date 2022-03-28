//
//  File.swift
//  
//
//  Created by Johandre Delgado on 28.03.2022.
//

import Foundation

public struct ArtResponse: Decodable {
  public var data: [Artwork]
}

public struct Artwork: Codable, Identifiable {
  public let id: Int
  public let title: String
  public let thumbnail: Thumbnail
  public let imageID: String
  
  public var imageURL: URL? {
  //https://www.artic.edu/iiif/2/0330a6dd-774e-eff1-0073-2be5f85b81d0/full/130,/0/default.jpg
    let UrlString = "https://www.artic.edu/iiif/2/\(imageID)/full/130,/0/default.jpg"
    return URL(string: UrlString)
  }
  
  enum CodingKeys: String, CodingKey {
    case id, title, thumbnail
    case imageID = "image_id"
  }
}

public struct Thumbnail: Codable {
  public let lqip: String
  public let width, height: Int
  public let altText: String

    enum CodingKeys: String, CodingKey {
        case lqip, width, height
        case altText = "alt_text"
    }
}

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
  
  var userMessage: String {
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
