//
//  PBPokemonListPresenter.swift
//  PokeBook
//
//  Created by user on 7/19/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import Foundation

protocol PBPokemonListView: class {
  func reloadList()
  func insertItems(at indexes: [Int])
  func startLoadingMore()
  func stopLoadingMore()
  func showError(title: String, message: String)
  func showPokemonDetails()
}

class PBPokemonListPresenter: PBPokemonListViewPresenter {
  
  fileprivate weak var view: PBPokemonListView?
  fileprivate var pokemons = [Pokemon]()
  fileprivate var dataSource = PBPokemonRepository.shared
  fileprivate var selectedPokemon: Int?
  
  func attach(_ view: PBPokemonListView) {
    self.view = view
    loadPokemons(count: 10)
  }
  
  func deattachView() {
    self.view = nil
  }
  
  var itemsCount: Int  {
    return pokemons.count
  }
  
  func item(for index: Int) -> Pokemon {
    return pokemons[index]
  }
  
  func prepareItem(for index: Int) {
    if index >= itemsCount - 1 {
      loadPokemons(count: 5)
    }
  }
  
  func itemSelectedAt(at index: Int) {
    selectedPokemon = index
    view?.showPokemonDetails()
  }
  
  func itemToDetailShow() -> Pokemon {
    return pokemons[selectedPokemon!]
  }
  
}

private extension PBPokemonListPresenter {
  
  func loadPokemons(count: Int) {
    view?.startLoadingMore()
    dataSource.getPokemons(offset: itemsCount, limit: count) { [weak self] pokemonsArr, error in
      if error == nil, let startIndex = self?.itemsCount {
        self?.pokemons += pokemonsArr
        self?.view?.insertItems(at: Array(startIndex..<startIndex + count))
      }
      self?.view?.stopLoadingMore()
    }
  }
  
}
