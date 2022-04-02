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
  @Published private(set) var pagination:  Pagination?
  @Published private(set) var  loading = false
  @Published private(set) var  showLoadingRow = false
  
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
        self?.pagination = artResponse.pagination
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
  
  func loadArtworksPage(after lastID: Artwork.ID) {
    
    guard lastID == artworks.last?.id, let pagination = pagination, pagination.currentPage < pagination.totalPages else {
      return
    }
    guard !showLoadingRow else { return }
    
    let page = (pagination.currentPage + 1).description
    var endPoint = ArtEndPoint.artworks
    endPoint.queryItems = [URLQueryItem(name: "page", value: page)]
    
    showLoadingRow = true
    service.fetch(ArtResponse.self, from: endPoint) { [weak self] result in
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // time for animations if fetch is too quick
        switch result {
        case .success(let artResponse):
          self?.artworks.append(contentsOf: artResponse.data)
          self?.resourcePath = artResponse.resourcePath
          self?.pagination = artResponse.pagination
        case .failure(let error):
          log("👀 artResponse error:", error.localizedDescription)
        }
        self?.showLoadingRow = false
        self?.loading = false
      }
    }
    
  }
}
