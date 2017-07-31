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
  func startLoading()
  func stopLoading()
  func showError(title: String, message: String)
}

class PBPokemonListPresenter: PBPokemonListViewPresenter {
  
  fileprivate weak var view: PBPokemonListView?
  fileprivate var pokemons = [Pokemon]()
  fileprivate var service = PBPokemonService()
  
  func attach(_ view: PBPokemonListView) {
    self.view = view
    //loadPokemons()
  }
  
  func deattachView() {
    self.view = nil
  }
  
  var itemsCount: Int  { return pokemons.count }
  
  func item(for index: Int) -> Pokemon {
    return pokemons[index]
  }
  
  
}

private extension PBPokemonListPresenter {
  
  func loadPokemons() {
    view?.startLoading()
    service.loadPokemons(offset: 0) { [weak self] pokemonsArr, error in
      if error == nil {
        self?.pokemons = pokemonsArr
        self?.view?.updateList()
      }
      self?.view?.stopLoading()
    }
  }
}
