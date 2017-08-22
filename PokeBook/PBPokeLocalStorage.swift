//
//  PBPokeLocalStorage.swift
//  PokeBook
//
//  Created by user on 8/1/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PBPokeLocalStorage {
  
  let cacheDirectory = try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
  func save(pokemon: Pokemon) {
    let _ = PokemonMO(pokemon)
    try! CoreDataController.shared.commit()
  }
  
  func save(pokemons: [Pokemon]) {
    for pok in getUsavedPokemons(from: pokemons) {
      let _ = PokemonMO(pok)
    }
    try! CoreDataController.shared.commit()
  }
  
  func loadPokemon(by id: Int, completion: @escaping (Pokemon?, Error?) -> Void) {
    let request = PokemonMO.fetchRequest(by: id)
    do {
      let pokemons = try CoreDataController.shared.context.fetch(request)
      guard let pokemon = pokemons.first else {
        completion(nil, PBServiceError.other)
        return
      }
      completion(Pokemon(pokemon), nil)

    } catch let error as NSError { completion(nil, error) }
  }
  
  func loadPokemons(offset: Int, limit: Int, completion: @escaping ([Pokemon], Error?) -> Void) {
    let _completion: ([Pokemon], Error?) -> Void =  { (pokemons, error) in
      DispatchQueue.main.async { completion(pokemons, error) }
    }
    let request = PokemonMO.fetchRequest(offset: offset, limit: limit)
    do {
      let pokemons = try CoreDataController.shared.context.fetch(request)
      guard pokemons.count > 0 else {
        _completion([], PBServiceError.other)
        return
      }
      let pokemonsArr = pokemons.map({ Pokemon($0) })
      _completion(pokemonsArr, nil)
  
    } catch let error as NSError { _completion([], error) }
  }
  
  private func getUsavedPokemons(from arr: [Pokemon]) -> [Pokemon] {
    let suggestIds = arr.map{ $0.id }
    let result = try! CoreDataController.shared.context.fetch(PokemonMO.fetchRequest(byIdentifiers: suggestIds)) as! [[String: Int]]
    let existingId = result.map { $0.first!.value }
    
    let pokemonsToSave = arr.filter { !existingId.contains($0.id) }
    return pokemonsToSave
  }
  
}
