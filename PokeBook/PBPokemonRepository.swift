//
//  PBPokemonRepository.swift
//  PokeBook
//
//  Created by user on 8/1/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation
import UIKit.UIImage

class PBPokemonRepository {
  
  private let cacheService: PBPokeLocalStorage
  private let networkService: PBPokeService
  
  static let shared = PBPokemonRepository()
  
  private init() {
    self.cacheService = PBPokeLocalStorage()
    self.networkService = PBPokeService()
  }
  
  func getPokemon(by id: Int, completion: @escaping (Pokemon?, Error?) -> Void) {
    networkService.loadPokemon(by: id, completion: completion)
  }
  
  func getPokemons(offset: Int, limit: Int, completion: @escaping ([Pokemon], Error?) -> Void) {
    cacheService.loadPokemons(offset: offset, limit: limit, completion: { [unowned self] pokemons, error in
      if error == nil {
        completion(pokemons, error)
      } else {
        self.networkService.loadPokemons(offset: offset, limit: limit, completion: { [weak self] pokemons, error in
          self?.cacheService.save(pokemons: pokemons)
          completion(pokemons, error)
        })
      }
    })
  }
  
  func getPokemonSprite(by url: String, completion: @escaping (UIImage) -> Void) {
    guard let url = URL(string: url) else { return }
    
    if let image = cacheService.getPokemonSprite(by: url) {
      completion(image)
    } else {
      loadPokemonImageFromServer(url: url, completion: completion)
    }
  }
  
  func savePokemonSprite(_ sprite: UIImage, at url: String) {
    guard let url = URL(string: url) else { return }
    cacheService.saveSprite(sprite, at: url)
  }
  
  private func loadPokemonImageFromServer(url: URL, completion: @escaping (UIImage) -> Void) {
    PBSpritesService.getPokemonSprite(byUrl: url, completion: { [weak self] image in
      if let sprite = image {
        self?.cacheService.saveSprite(sprite, at: url)
        completion(sprite)
      } else {
        completion(UIImage(named: "pikachu")!)
      }
    })
  }
  
}
