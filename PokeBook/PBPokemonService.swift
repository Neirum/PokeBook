//
//  PBPokemonService.swift
//  PokeBook
//
//  Created by user on 7/19/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//
import Foundation


final class PBPokemonService {
  
  private let client = PBPokeClient(baseUrl: PokemonApi.pokemonEndPoint)
  
  func loadPokemon(by id: Int, completion: @escaping (Pokemon?, PBServiceError?) -> Void ) -> URLSessionDataTask? {
    return client.load(path: "\(id)", method: .get, params: [:]) { result, error in
      let res = result as? JSON
      completion(Pokemon(jsonDict: res), error)
    }
  }
  
  
}
