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
  @Published private(set) var items = ["uno", "dos"]
  @Published private(set) var artworks: [Artwork] = []
  
  private var service: Networkable
  
  init(service: Networkable = NetworkService()) {
    self.service = service
    service.fetchSample()
    getArtworks()
  }
  
  func getArtworks() {
    service.fetch(ArtResponse.self, from: .artworks) { [weak self] result in
      switch result {
      case .success(let artResponse):
        print("👀 artResponse:", artResponse.data.count)
        self?.artworks = artResponse.data
        print("👀 first art id: ", artResponse.data.first?.imageID)
      case .failure(let error):
        print("👀 artResponse error:", error.localizedDescription)
      }
    }
  }
  
}

struct ContentView: View {
  @StateObject var viewModel = HomeViewModel()
  
  var body: some View {
    Color.Background.accent
      .overlay(
        VStack {
          Text(viewModel.items[0])
            .padding()
          List {
            ForEach(viewModel.artworks) { art in
              HStack {
                if let url = art.imageURL {
                  ArtThumbView(url: url)
                    .frame(width: 34, height: 34)
                }
                Text(art.title)
              }
            }
          }
          .padding(.horizontal)
          .refreshable {
            viewModel.getArtworks()
          }
        }
      )
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}


struct ArtThumbView: View {
  let url: URL
  
  var body: some View {
    AsyncImage(url: url) { image in
      image
        .resizable()
        .scaledToFit()
    } placeholder: {
      Color.Background.accent.opacity(0.3)
        .cornerRadius(24)
        .opacity(0.1)
        .overlay(ProgressView())
    }

  }
}
