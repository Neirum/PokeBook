//
//  PBPokeLocalStorage+Sprites.swift
//  PokeBook
//
//  Created by user on 8/15/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation
import UIKit.UIImage

extension PBPokeLocalStorage {

  func getPokemonSprite(by url: URL) -> UIImage? {
    guard
      let fileName = getNameForFileFrom(url: url),
      let filePath = URL(string: fileName, relativeTo: cacheDirectory),
      let imageData = try? Data.init(contentsOf: filePath)
      else { return nil }
    return UIImage(data: imageData)
  }
  
  func saveSprite(_ sprite: UIImage, at url: URL) {
    guard
      let fileName = getNameForFileFrom(url: url),
      let filePath = URL(string: fileName, relativeTo: cacheDirectory)
    else {
      return
    }
    try! UIImagePNGRepresentation(sprite)?.write(to: filePath)
  }
  
  private func getNameForFileFrom(url: URL) -> String? {
    return url.absoluteString.components(separatedBy: "sprites/").last?.replacingOccurrences(of: "/", with: "_")
  }
  
}
