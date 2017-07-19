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
    case name
    case height
    case weight
    case sprites
  }

  let name: String
  let weight: Int
  let height: Int
  var sprite: UIImage?

}
extension Pokemon {
  
  init?(jsonDict: [String: Any]?) {
    guard let name = jsonDict?[JsonKeys.name.rawValue] as? String,
          let weight = jsonDict?[JsonKeys.weight.rawValue] as? Int,
          let height = jsonDict?[JsonKeys.height.rawValue] as? Int
      else {
        return nil
    }
    self.name = name
    self.weight = weight
    self.height = height
    
    if let spriteUrl = (jsonDict?[JsonKeys.sprites.rawValue] as? [String: String])?["front_default"],
       let imgData = try? Data(contentsOf: URL(string: spriteUrl)!) {
      self.sprite = UIImage(data: imgData)
    }
  }
  
}
