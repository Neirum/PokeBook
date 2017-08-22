//
//  PBSpitesService.swift
//  PokeBook
//
//  Created by user on 7/31/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation
import UIKit


class PBSpritesService {
  
  class func getPokemonSprite(byUrl url: URL, completion: @escaping (UIImage?) -> Void) {
    loadPokemonSprite(byUrl: url, completion: completion)
  }
  
}

private extension PBSpritesService {
  
  class func loadPokemonSprite(byUrl url: URL, completion: @escaping (UIImage?) -> Void) {
    print("Loading sprite from server")
    DispatchQueue.global(qos: .utility).async {
      if let data = try? Data(contentsOf: url),
        let image = UIImage(data: data) {
        DispatchQueue.main.async { completion(image) }
      } else {
        DispatchQueue.main.async { completion(nil) }
      }
    }
  }
  
}
