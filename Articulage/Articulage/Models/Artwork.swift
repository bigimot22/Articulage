//
//  Artwork.swift
//  Articulage
//
//  Created by Johandre Delgado on 29.03.2022.
//

import Foundation

public struct Artwork: Codable, Identifiable {
  public let id: Int
  public let title: String
  public let imageID: String?
  public let artistTitle: String?
  public let provenanceDescription: String?
  public let displayYear: String
  
  enum CodingKeys: String, CodingKey {
    case id, title
    case artistTitle = "artist_title"
    case imageID = "image_id"
    case provenanceDescription = "provenance_text"
    case displayYear = "date_display"
  }
}

