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
  
  static let shared: PBSpritesService = PBSpritesService()
  
  fileprivate var cache: [URL: Data]
  
  private init() {
    self.cache = [URL: Data]()
  }
  
  func getPokemonSprite(byUrl url: URL, completion: @escaping (UIImage) -> Void) {
    if let data = cache[url] {
      print("Getting image from cache")
      completion(UIImage(data: data)!)
    } else {
      print("Loading image")
      loadPokemonSprite(byUrl: url, completion: completion)
    }
  }
  
}

private extension PBSpritesService {
  
  func loadPokemonSprite(byUrl url: URL, completion: @escaping (UIImage) -> Void) {
    DispatchQueue.global(qos: .utility).async { [unowned self] in
      if let data = try? Data(contentsOf: url),
        let image = UIImage(data: data) {
        self.cache[url] = data
        DispatchQueue.main.async { completion(image) }
      } else {
        DispatchQueue.main.async { completion(UIImage(named: "pikachu")!) }
      }
    }
  }
  
}
