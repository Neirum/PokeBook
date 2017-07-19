//
//  PBPokemonTableViewCell.swift
//  PokeBook
//
//  Created by user on 7/18/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//

import UIKit


class PBPokemonTableViewCell: UITableViewCell {

  @IBOutlet weak var pokemonImg: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var heightLabel: UILabel!
  @IBOutlet weak var weightLabel: UILabel!
  
  private var name: String = "..." {
    didSet { nameLabel.text = name }
  }
  private var heightText: String = "0" {
    didSet { heightLabel.text = heightText}
  }
  
  private var weightText: String = "0" {
    didSet { weightLabel.text = weightText }
  }

  func config(with pokemon: Pokemon) {
    self.name = pokemon.name
    self.weightText = String(describing: pokemon.weight)
    self.heightText = String(describing: pokemon.height)
  }
  
  
}
