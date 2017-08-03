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
  
  convenience init(context: NSManagedObjectContext) {
    self.init(entity: PokemonMO.entity(), insertInto: context)
  }
}
