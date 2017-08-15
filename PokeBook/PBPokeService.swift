//
//  PBPokemonService.swift
//  PokeBook
//
//  Created by user on 7/19/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//
import Foundation

final class PBPokeService {
  
  private let client = PBPokeClient(baseUrl: PokemonApi.pokemonEndPoint)
  
  func loadPokemon(by id: Int, completion: @escaping (Pokemon?, Error?) -> Void) {
    let _ = client.load(path: "\(id)", method: .get, params: [:]) { result, error in
      let res = result as? JSON
      completion(Pokemon(jsonDict: res), error)
    }
  }
  
  func loadPokemons(offset: Int, limit: Int, completion: @escaping ([Pokemon], Error?) -> Void) {
    guard offset < 50 else {
      completion([], PBServiceError.other)
      return
    }
    let loadGroup = DispatchGroup()
    var pokemons = [Pokemon]()
    let startIndex = offset + 1
    for i in startIndex..<(startIndex + limit) {
      loadGroup.enter()
      DispatchQueue.global(qos: .utility).async(group: loadGroup) { [unowned self] in
        self.loadPokemon(by: i) { (result, error) in
          if let pokemon = result {
            pokemons.append(pokemon)
          }
          loadGroup.leave()
        }
      }
    }
    loadGroup.notify(queue: DispatchQueue.main) {
      pokemons.sort(by: { $0.id < $1.id })
      if pokemons.count < 1 {
        completion(pokemons, PBServiceError.other)
      } else {
        completion(pokemons, nil)
      }
    }
  }
  
  
}
