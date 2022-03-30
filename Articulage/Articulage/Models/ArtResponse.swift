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
  let pagination: Pagination
  public let resourcePath: ResourcePath
  
  enum CodingKeys: String, CodingKey {
      case data, pagination
      case resourcePath = "config"
  }
}

struct Pagination: Codable {
    let total, limit, offset, totalPages: Int
    let currentPage: Int
    let nextURL: String

    enum CodingKeys: String, CodingKey {
        case total, limit, offset
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case nextURL = "next_url"
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
