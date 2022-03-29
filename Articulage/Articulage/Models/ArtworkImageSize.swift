//
//  ArtworkImageSize.swift
//  Articulage
//
//  Created by Johandre Delgado on 29.03.2022.
//

import Foundation
// more info: https://api.artic.edu/docs/#image-sizes
enum ArtworkImageSize: Int {
  case small = 200
  case medium = 400
  case large = 600
  case full = 843 // recommended by API authors
  case extraLarge = 1686
  
  var stringValue: String {
    self.rawValue.description
  }
}
