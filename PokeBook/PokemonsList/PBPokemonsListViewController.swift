//
//  PBPokemonsListViewController.swift
//  PokeBook
//
//  Created by user on 7/18/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//
import UIKit

class PBPokemonsListViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }

  
}

extension PBPokemonsListViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell") as! PBPokemonTableViewCell
    
    return cell
  }
  
  
}
