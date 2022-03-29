//
//  ArtResponse.swift
//  Articulage
//
//  Created by Johandre Delgado on 29.03.2022.
//

import Foundation

public struct ArtDetailResponse: Decodable {
  public var data: [Artwork]
}

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
