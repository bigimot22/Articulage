//
//  ContentView.swift
//  Articulage
//
//  Created by Johandre Delgado on 28.03.2022.
//

import SwiftUI
import ArtUI

struct ContentView: View {
    var body: some View {
      Color.Background.accent
        .overlay(
          Text("Hello!")
              .padding()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
