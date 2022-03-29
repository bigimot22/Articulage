//
//  ContentView.swift
//  Articulage
//
//  Created by Johandre Delgado on 28.03.2022.
//

import SwiftUI
import ArtUI

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
        print("👀 artResponse error:", error.localizedDescription)
      }
      self?.loading = false
    }
  }
  
  func artworkImageURL(withID id: Artwork.ID) -> URL? {
    guard let imageID = artworks.first(where: { $0.id == id})?.imageID, let resourcesPath = resourcePath else { return nil }
    let urlString = "\(resourcesPath.iiifURL)/\(imageID)/full/130,/0/default.jpg"
    return URL(string: urlString)
  }
  
}

struct ContentView: View {
  @StateObject var viewModel = HomeViewModel()
  
  init() {
    UITableView.appearance().showsVerticalScrollIndicator = false
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.artworks.filter { $0.imageID != nil}) { art in
          HStack(alignment: .top, spacing: 16) {
            if let url = viewModel.artworkImageURL(withID: art.id) {
              ArtThumbView(url: url)
                .frame(width: 100, height: 100)
                .padding()
                .background(Color.Background.blackLight)
                .cornerRadius(8)
            }
            VStack(alignment: .leading, spacing: 0) {
              Text(art.title)
                .font(.title3)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
              if let artist = art.artistTitle {
                Text(artist)
                  .font(.callout)
                  .fontWeight(.semibold)
              }
              if let provenance = art.provenanceDescription {
                Text(provenance)
                  .font(.callout)
                  .fontWeight(.light)
                  .truncationMode(.tail)
                  .frame(maxHeight: 80)
                  .padding(.vertical)
              }
              Spacer()
              Text(art.displayYear)
                .font(.subheadline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
          }
          .padding()
          .background(Color.Background.primary)
          .cornerRadius(12)
          .padding(.vertical, 8)
          .redacted(reason: viewModel.loading ? .placeholder : [])
        }
        .listRowSeparator(.hidden)
      }
      .refreshable {
        viewModel.reloadArtworks()
      }
      .navigationBarTitle("Articulage")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

import SDWebImageSwiftUI
struct ArtThumbView: View {
  let url: URL
  
  var body: some View {
    WebImage(url: url)
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .cornerRadius(8)
  }
}
