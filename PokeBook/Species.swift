//
//  Species.swift
//  PokeBook
//
//  Created by user on 8/18/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation


struct Species {
  
  fileprivate enum JsonKeys: String {
    case id
    case name
    case color
    case varieties
  }
  
  let id: Int
  let name: String
  let color: String
  let varieties: [Pokemon]
  
}

extension Species {
  
  init?(jsonDict: [String: Any]) {
    guard
      let id = jsonDict[JsonKeys.id.rawValue] as? Int,
      let name = jsonDict[JsonKeys.name.rawValue] as? String,
      let color = jsonDict[JsonKeys.color.rawValue] as? String,
      let varietiesJson = jsonDict[JsonKeys.varieties.rawValue] as? [[String: Any]]
    else { return nil }
    
    let varieties = varietiesJson.map{ Pokemon(jsonDict: $0) }.flatMap{ $0 }
    guard varieties.count > 0 else { return nil }
  
    self.id = id
    self.name = name
    self.color = color
    self.varieties = varieties
  }
  
}
