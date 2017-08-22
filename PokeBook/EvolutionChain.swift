//
//  EvolutionChain.swift
//  PokeBook
//
//  Created by user on 8/18/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation

struct EvolutionChain {
  
  fileprivate enum JsonKeys: String {
    case id
    case chain
  }
  
  let id: Int
  let rootChain: Chain
  
}

extension EvolutionChain {
  
  init?(jsonDict: [String: Any]) {
    guard
      let id = jsonDict[JsonKeys.id.rawValue] as? Int,
      let chainJson = jsonDict[JsonKeys.chain.rawValue] as? [String: Any],
      let rootChain = Chain.init(jsonDict: chainJson)
    else { return nil }
    
    self.id = id
    self.rootChain = rootChain
  }
  
}
