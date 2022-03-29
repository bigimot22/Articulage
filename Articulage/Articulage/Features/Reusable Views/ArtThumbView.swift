//
//  ArtThumbView.swift
//  Articulage
//
//  Created by Johandre Delgado on 29.03.2022.
//

import SwiftUI
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
struct ArtThumbView_Previews: PreviewProvider {
  static let url = URL(string: "https://www.artic.edu/iiif/2/1adf2696-8489-499b-cad2-821d7fde4b33/full/843,/0/default.jpg")!
    static var previews: some View {
      ArtThumbView(url: url).padding()
    }
}
