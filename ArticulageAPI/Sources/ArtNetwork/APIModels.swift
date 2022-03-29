//
//  File.swift
//  
//
//  Created by Johandre Delgado on 28.03.2022.
//

import Foundation

public struct ArtResponse: Decodable {
  public var data: [Artwork]
  public let resourcePath: ResourcePath
  
  enum CodingKeys: String, CodingKey {
      case data
      case resourcePath = "config"
  }
}

public struct ResourcePath: Codable {
  public let iiifURL: String
  public let websiteURL: String

    enum CodingKeys: String, CodingKey {
        case iiifURL = "iiif_url"
        case websiteURL = "website_url"
    }
}

public struct Artwork: Codable, Identifiable {
  public let id: Int
  public let title: String
  public let imageID: String?
  public let artistTitle: String?
  
  enum CodingKeys: String, CodingKey {
    case id, title
    case artistTitle = "artist_title"
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
