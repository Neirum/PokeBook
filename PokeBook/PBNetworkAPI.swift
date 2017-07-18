//
//  PBNetworkAPI.swift
//  PokeBook
//
//  Created by user on 7/18/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation


class PBNetworkAPI {
  
  static let shared = PBNetworkAPI()
 
  private init() {}
  
  let kPBPokemonEndPoint = "https://pokeapi.co/api/v2/pokemon/"
  let kPBPokemonSpritesEndPoint = "http://pokeapi.co/media/sprites/pokemon/"
  let kPBItemsSpritesEndPoint = "http://pokeapi.co/media/sprites/items/"


}
