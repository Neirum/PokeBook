//
//  PokemonMO.swift
//  PokeBook
//
//  Created by user on 8/3/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation
import CoreData

extension PokemonMO {
  
  public class func fetchRequest(by id: Int) -> NSFetchRequest<PokemonMO> {
    let fetch: NSFetchRequest<PokemonMO> = PokemonMO.fetchRequest()
    let predicate = NSPredicate(format: "id == %@", id)
    fetch.predicate = predicate
    return fetch
  }
  
  public class func fetchRequest(byIdentifiers ids: [Int]) -> NSFetchRequest<NSFetchRequestResult> {
    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PokemonEntity")
    fetch.resultType = .dictionaryResultType
    fetch.propertiesToFetch = ["id"]
    fetch.predicate = NSPredicate(format: "id IN %@", ids)
    return fetch
  }
  
  public class func fetchRequest(offset: Int, limit: Int) -> NSFetchRequest<PokemonMO> {
    let fetch: NSFetchRequest<PokemonMO> = PokemonMO.fetchRequest()
    let sortDescr = NSSortDescriptor.init(key: "id", ascending: true)
    fetch.sortDescriptors = [sortDescr]
    fetch.fetchLimit = limit
    fetch.fetchOffset = offset
    return fetch
  }
    
  convenience init(context: NSManagedObjectContext) {
    self.init(entity: PokemonMO.entity(), insertInto: context)
  }
  
  convenience init() {
    self.init(entity: PokemonMO.entity(), insertInto: CoreDataController.shared.context)
  }
  
  convenience init(id: Int, name: String, imageUrl: String) {
    self.init(entity: PokemonMO.entity(), insertInto: CoreDataController.shared.context)
    self.id = Int16(id)
    self.name = name
    self.imageUrl = imageUrl
  }
  
  convenience init(_ pokemon: Pokemon) {
    self.init(id: pokemon.id, name: pokemon.name, imageUrl: pokemon.imageUrl)
  }
  
  
}
