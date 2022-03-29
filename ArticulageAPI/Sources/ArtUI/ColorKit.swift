//
//  File.swift
//  
//
//  Created by Johandre Delgado on 28.03.2022.
//

import SwiftUI

public extension Color {
  
  // MARK: - Initializers
  init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (1, 1, 1, 0)
    }
    
    self.init(
      .sRGB,
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue:  Double(b) / 255,
      opacity: Double(a) / 255
    )
  }
  
  // MARK: - Palette
  private enum Palette {
    public static let brand = Color("Colors/brand", bundle: .module)
    public static let primary = Color("Colors/primary", bundle: .module)
    public static let secondary = Color("Colors/secondary", bundle: .module)
    public static let background = brand
  }
  
  enum Constant {
    public static let white = Color("Constant/white", bundle: .module)
    public static let black = Color("Constant/black", bundle: .module)
  }
  
  enum System {
    public static let silver = Color("Colors/silver", bundle: .module)
    public static let gray6 = Color("Colors/gray6", bundle: .module)
    public static let indigo = Color.indigo
  }
  
  enum Text {
    public static let accent = Color("Text/accent", bundle: .module)
    public static let disabled = Color("Text/disabled", bundle: .module)
    public static let error = Color("Text/error", bundle: .module)
    public static let link = Color("Text/link", bundle: .module)
    public static let primary = Color("Text/primary", bundle: .module)
    public static let secondary = Color("Text/secondary", bundle: .module)
    public static let tertiary = Color("Text/tertiary", bundle: .module)
    public static let white = Constant.white
    public static let black = Constant.black
  }
  
  enum Background {
    public static let primary = Color("Background/primary", bundle: .module)
    public static let secondary = Color("Background/secondary", bundle: .module)
    public static let tertiary = Color("Background/tertiary", bundle: .module)
    public static let accent = Color("Background/accent", bundle: .module)
    public static let grayLight = Color("Background/gray-light", bundle: .module)
    public static let blackLight = Color("Background/black-light", bundle: .module)
  }
  
  enum Button {
    public static let primary = Color("Button/primary", bundle: .module)
    public static let secondary = Color("Button/secondary", bundle: .module)
  }
}



