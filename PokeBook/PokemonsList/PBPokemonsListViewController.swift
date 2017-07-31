//
//  PBPokemonsListViewController.swift
//  PokeBook
//
//  Created by user on 7/18/17.
//  Copyright © 2017 StasZherebkin. All rights reserved.
//
import UIKit

protocol PBPokemonListViewPresenter {
  func attach(_ view: PBPokemonListView)
  func deattachView()
  func item(for index: Int) -> Pokemon
  var itemsCount: Int { get }
}

class PBPokemonsListViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  fileprivate let presenter: PBPokemonListViewPresenter = PBPokemonListPresenter()
  fileprivate var loadMoreStatus = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.attach(self)
    tableView.tableFooterView?.isHidden = true
  }



  
  @IBAction func updateBarButtonTapped(_ sender: Any) {
    
  }
}

extension PBPokemonsListViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.itemsCount
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell") as! PBPokemonTableViewCell
    cell.config(with: presenter.item(for: indexPath.row))
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return PBPokemonTableViewCell.rowHigh()
  }
  
}

extension PBPokemonsListViewController: PBPokemonListView {
  
  func updateList() {
    tableView.reloadData()
  }
  
  func startLoading() {
  
  }
  
  func stopLoading() {

  }
  
  func showError(title: String, message: String) {
    print(title)
    print(message)
  }
  
}
