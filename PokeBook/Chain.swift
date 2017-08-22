//
//  Chain.swift
//  PokeBook
//
//  Created by user on 8/18/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.


import Foundation


class Chain {
  
  fileprivate enum JsonKeys: String {
    case evolvesTo = "evolves_to"
    case species
  }
  
  let evolvesTo: Chain?
  let species: Species
  
  init(species: Species, evolvesTo: Chain? = nil) {
    self.species = species
    self.evolvesTo = evolvesTo
  }
  
  init?(jsonDict: [String: Any]) {
    guard
      let speciesJson = jsonDict[JsonKeys.species.rawValue] as? [String: Any],
      let species = Species(jsonDict: speciesJson)
    else { return nil }
    self.species = species
    
    if let nextChainJson = jsonDict[JsonKeys.evolvesTo.rawValue] as? [String: Any] {
      self.evolvesTo = Chain(jsonDict: nextChainJson)
    } else {
      self.evolvesTo = nil
    }
  }
  
}
