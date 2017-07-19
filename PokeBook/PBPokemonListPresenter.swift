//
//  PBPokemonListPresenter.swift
//  PokeBook
//
//  Created by user on 7/19/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation

protocol PBPokemonListView: class {
  func updateList()
  
}

class PBPokemonListPresenter {
  
  private weak var view: PBPokemonListView
  
  init(_ view: PBPokemonListView) {
    self.view = view
  }
}
