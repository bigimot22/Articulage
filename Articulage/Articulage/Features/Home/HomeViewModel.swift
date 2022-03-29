//
//  HomeViewModel.swift
//  Articulage
//
//  Created by Johandre Delgado on 29.03.2022.
//

import Foundation
import Combine
import Utilities

import ArtNetwork
final class HomeViewModel: ObservableObject {
  @Published private(set) var artworks: [Artwork] = []
  @Published private(set) var  loading = false
  
  private var service: Networkable
  private var resourcePath: ResourcePath?
  
  init(service: Networkable = NetworkService()) {
    self.service = service
    getArtworks()
  }
  
  func reloadArtworks() {
    loading = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
      self.getArtworks()
    }
  }
  
  func getArtworks() {
    loading = true
    service.fetch(ArtResponse.self, from: ArtEndPoint.artworks) { [weak self] result in
      switch result {
      case .success(let artResponse):
        self?.artworks = artResponse.data
        self?.resourcePath = artResponse.resourcePath
      case .failure(let error):
        log("👀 artResponse error:", error.localizedDescription)
      }
      self?.loading = false
    }
  }
  
  func artworkImageURL(withID id: Artwork.ID, size: ArtworkImageSize = .full) -> URL? {
    guard let imageID = artworks.first(where: { $0.id == id})?.imageID, let resourcesPath = resourcePath else { return nil }
    let urlString = "\(resourcesPath.iiifURL)/\(imageID)/full/\(size.stringValue),/0/default.jpg"
    return URL(string: urlString)
  }
}
