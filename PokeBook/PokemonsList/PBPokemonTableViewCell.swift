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
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  private var name: String = "..." {
    didSet { nameLabel.text = name }
  }
  private var heightText: String = "0" {
    didSet { heightLabel.text = heightText}
  }
  
  private var weightText: String = "0" {
    didSet { weightLabel.text = weightText }
  }

  private var imageUrl: String = "" {
    didSet {
      activityIndicator.startAnimating()
      PBSpritesService.shared.getPokemonSprite(byUrl: URL(string: imageUrl)!) { [weak self] image in
        self?.pokemonImg.image = image
        self?.activityIndicator.stopAnimating()
      }
    }
  }
  
  func config(with pokemon: Pokemon) {
    self.name = pokemon.name
    self.weightText = "Weight: \(String(describing: pokemon.weight))"
    self.heightText = "Height: \(String(describing: pokemon.height))"
    self.imageUrl = pokemon.imageUrl
  }
  
  class func rowHigh() -> CGFloat {
    return 96
  }
  
}
