//
//  File.swift
//  
//
//  Created by Johandre Delgado on 28.03.2022.
//

import Foundation

public protocol EndPoint {
  var path: String { get set }
  var queryItems: [URLQueryItem] { get set }
  var url: URL { get }
}
