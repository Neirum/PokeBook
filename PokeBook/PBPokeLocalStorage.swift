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
  
  func save(pokemon: Pokemon) {
    create(pokemon: pokemon)
    try! CoreDataController.shared.commit()
  }
  
  func save(pokemons: [Pokemon]) {
    for pok in pokemons {
      create(pokemon: pok)
    }
    try! CoreDataController.shared.commit()
  }
  
  func loadPokemon(by id: Int, completion: @escaping (Pokemon?, Error?) -> Void) {
    let context = CoreDataController.shared.context
    let request: NSFetchRequest<PokemonMO> = PokemonMO.fetchRequest()
    
    do {
      let pokemons = try context.fetch(request)
      let fetchedPok = pokemons.last
      guard let pokemon = fetchedPok else {
        completion(nil, nil)
        return
      }
      completion(Pokemon.init(id: Int(pokemon.id),
                              name: pokemon.name!,
                              weight: 0, height: 0,
                              imageUrl: pokemon.imageUrl!,
                              sprite: nil),
                 nil)
    } catch let error as NSError {
      completion(nil, error)
      print(error)
    }
  }
  
}

fileprivate extension PBPokeLocalStorage {
  
  func create(pokemon: Pokemon) {
    let pokemonMO = PokemonMO(context: CoreDataController.shared.context)
    
    pokemonMO.name = pokemon.name
    pokemonMO.id = Int16(pokemon.id)
    pokemonMO.imageUrl = pokemon.imageUrl
  }
  
}
