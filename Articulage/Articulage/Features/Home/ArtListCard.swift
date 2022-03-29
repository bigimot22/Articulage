//
//  ArtListCard.swift
//  Articulage
//
//  Created by Johandre Delgado on 29.03.2022.
//

import SwiftUI

struct ArtListCard: View {
  let artwork: Artwork
  let imageURL: URL?
  
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      if let url = imageURL {
        ArtThumbView(url: url)
          .frame(width: 100, height: 100)
          .padding()
          .background(Color.Background.blackLight)
          .cornerRadius(8)
      }
      
      VStack(alignment: .leading, spacing: 0) {
        Text(artwork.title)
          .font(.title3)
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .leading)
        if let artist = artwork.artistTitle {
          Text(artist)
            .font(.callout)
            .fontWeight(.semibold)
        }
        if let provenance = artwork.provenanceDescription {
          Text(provenance)
            .font(.callout)
            .fontWeight(.light)
            .truncationMode(.tail)
            .frame(maxHeight: 80)
            .padding(.vertical)
        }
        Spacer()
        Text(artwork.displayYear)
          .font(.subheadline)
          .fontWeight(.bold)
          .frame(maxWidth: .infinity, alignment: .trailing)
      }
    }
  }
}
