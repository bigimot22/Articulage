//
//  File.swift
//  
//
//  Created by Johandre Delgado on 29.03.2022.
//

import Foundation

@inlinable public func log(_ text: String, terminator: String? = nil) {
#if DEBUG
  terminator == nil ? print(text) : print(text, terminator: terminator!)
#endif
}

public func log(_ objects: Any...) -> () {
#if DEBUG
  log(objects.map{"\($0)"}.joined(separator: " "))
#endif
}
