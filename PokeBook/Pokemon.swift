//
//  Pokemon.swift
//  PokeBook
//
//  Created by user on 7/19/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation
import UIKit

struct Pokemon {
  
  enum JsonKeys: String {
    case id
    case name 
    case height
    case weight
    case sprites
  }
  
  let id: Int
  let name: String
  let weight: Int
  let height: Int
  let imageUrl: String

}

extension Pokemon {
  
  init?(jsonDict: [String: Any]?) {
    guard let name = jsonDict?[JsonKeys.name.rawValue] as? String,
          let weight = jsonDict?[JsonKeys.weight.rawValue] as? Int,
          let height = jsonDict?[JsonKeys.height.rawValue] as? Int,
          let id = jsonDict?[JsonKeys.id.rawValue] as? Int,
          let imageUrl = jsonDict?[JsonKeys.sprites.rawValue] as? [String: Any]
      else { return nil }
    
    self.id = id
    self.name = name
    self.weight = weight
    self.height = height
    self.imageUrl = imageUrl["front_default"] as! String
  }
  
  init() {
    self.id = 0
    self.name = "Pokemon"
    self.weight = 0
    self.height = 0
    self.imageUrl = "sprite/url"
  }
  
  init(_ pokemonMO: PokemonMO) {
    self.init(id: Int(pokemonMO.id),
              name: pokemonMO.name!,
              weight: 0, height: 0,
              imageUrl: pokemonMO.imageUrl!)
  }
  
}

extension Pokemon: Equatable {
  
  static func ==(lhs: Pokemon, rhs: Pokemon) -> Bool {
    return lhs.id == rhs.id
  }
  
}
