//
//  Hightlighted.swift
//  Articulage
//
//  Created by Johandre Delgado on 02.04.2022.
//

import SwiftUI

extension View {
  func higlighted(_ isActive: Bool = false) -> some View {
    modifier(Hightlighted(isActive: isActive))
  }
}

struct Hightlighted: ViewModifier {
  private var isActive: Bool
  @State private var offset: Double = -500
  
  init(isActive: Bool) {
    self.isActive = isActive
  }
  
  func body(content: Content) -> some View {
    ZStack {
      content
      if isActive {
        Rectangle()
          .frame(width: 5)
          .frame(maxHeight: .infinity)
          .foregroundColor(Color.white.opacity(0.3))
          .blur(radius: 10)
          .blendMode(.lighten)
          .offset(x: offset)
          .onAppear {
            let animation = Animation.easeInOut(duration: 2.5)
              .repeatForever(autoreverses: false)
            withAnimation(animation) {
              self.offset = 400.0
            }
          }
      }
    }
  }
}
