//
//  ContentView.swift
//  Articulage
//
//  Created by Johandre Delgado on 28.03.2022.
//

import SwiftUI
import ArtUI

struct HomeScreen: View {
  @StateObject var viewModel = HomeViewModel()
  
  init() {
    UITableView.appearance().showsVerticalScrollIndicator = false
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.artworks.filter { $0.imageID != nil}) { artwork in
          ArtListCard(artwork: artwork, imageURL: viewModel.artworkImageURL(withID: artwork.id, size: .small))
            .padding()
            .background(Color.Background.primary)
            .cornerRadius(12)
            .padding(.vertical, 8)
            .onAppear {
              viewModel.loadArtworksPage(after: artwork.id)
            }
        }
        .redacted(reason: viewModel.loading ? .placeholder : [])
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
    HomeScreen()
  }
}
