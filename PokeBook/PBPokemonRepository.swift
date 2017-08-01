//
//  PBPokemonRepository.swift
//  PokeBook
//
//  Created by user on 8/1/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation


class PBPokemonRepository {
  private init() {
    self.cacheService = PBPokeLocalStorage()
    self.networkService = PBPokeService()
  }
  
  private let cacheService: PBPokeLocalStorage
  private let networkService: PBPokeService
  
  static let shared = PBPokemonRepository()
  
  
  func getPokemon(by id: Int, completion: @escaping (Pokemon?, Error?) -> Void) {
    
  }
  
  func getPokemons(offset: Int, limit: Int, completion: @escaping ([Pokemon], Error?) -> Void) {
  
  }
  
  func getPokemonSprite(by url: String, completion: @escaping (Data) -> Void) {
    
  }
  
  
}
