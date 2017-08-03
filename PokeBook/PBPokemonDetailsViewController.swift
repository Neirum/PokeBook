//
//  PBPokemonDetailsViewController.swift
//  PokeBook
//
//  Created by user on 8/2/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import UIKit

class PBPokemonDetailsViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var pokemonToShow: Pokemon?
  let storage = PBPokeLocalStorage.init()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configView()
  }
  

  @IBAction func saveButtonDidTapped() {
    storage.save(pokemon: pokemonToShow!)
  }
 
  @IBAction func loadButtonDidTapped() {
    activityIndicator.startAnimating()
    storage.loadPokemon(by: 0) { [weak self] pokemon, error in
      if let pok = pokemon {
        self?.pokemonToShow = pok
      }
      self?.activityIndicator.stopAnimating()
      self?.configView()
    }
  }
  
}

extension PBPokemonDetailsViewController {
  
  func configView() {
    nameLabel.text = pokemonToShow!.name
    PBSpritesService.shared.getPokemonSprite(byUrl: URL(string:pokemonToShow!.imageUrl)!) { [weak self] image in
      self?.imageView.image = image
    }
  }
  
}
