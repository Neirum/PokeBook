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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configView()
  }
  

  @IBAction func saveButtonDidTapped() {

  }
 
  @IBAction func loadButtonDidTapped() {
    activityIndicator.startAnimating()
    PBPokemonRepository.shared.getPokemonSprite(by: pokemonToShow!.imageUrl) { [weak self] image in
      self?.imageView.image = image
      self?.activityIndicator.stopAnimating()
    }
  }
  
  @IBAction func deleteButtonDidTapped() {
    self.imageView.image = nil
  }
  
}

extension PBPokemonDetailsViewController {
  
  func configView() {
    nameLabel.text = pokemonToShow!.name
    PBPokemonRepository.shared.getPokemonSprite(by: pokemonToShow!.imageUrl) { [weak self] image in
      self?.imageView.image = image
      self?.activityIndicator.stopAnimating()
    }
  }
  
}
