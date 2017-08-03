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
  func itemSelectedAt(at index: Int)
  func itemToDetailShow() -> Pokemon
  func prepareItem(for index: Int)
  var itemsCount: Int { get }
}

class PBPokemonsListViewController: UIViewController {
  @IBOutlet fileprivate weak var tableView: UITableView!
  @IBOutlet fileprivate weak var bottomActivityIndicator: UIActivityIndicatorView!
  
  fileprivate let presenter: PBPokemonListViewPresenter = PBPokemonListPresenter()
  
  fileprivate var loadMoreStatus = false {
    didSet {
      if loadMoreStatus {
        tableView.tableFooterView?.isHidden = false
        bottomActivityIndicator.startAnimating()
      } else {
        tableView.tableFooterView?.isHidden = true
        bottomActivityIndicator.stopAnimating()
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView?.isHidden = true
    
    presenter.attach(self)
  }


  @IBAction func updateBarButtonTapped(_ sender: Any) {

  }
 
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    if segue.identifier == "detailPokemon" {
      let vc = segue.destination as! PBPokemonDetailsViewController
      vc.pokemonToShow = presenter.itemToDetailShow()
    }
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
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    presenter.prepareItem(for: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.itemSelectedAt(at: indexPath.row)
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}


extension PBPokemonsListViewController: PBPokemonListView {
  
  func reloadList() {
    tableView.reloadData()
  }
  
  func insertItems(at paths: [Int]) {
    let indexes = paths.map { IndexPath.init(row: $0, section: 0) }
    tableView.insertRows(at: indexes, with: .fade)
  }
  
  func startLoadingMore() {
    loadMoreStatus = true
  }
  
  func stopLoadingMore() {
    loadMoreStatus = false
  }
  
  func showError(title: String, message: String) {
    print(title)
    print(message)
  }
  
  func showPokemonDetails() {
    performSegue(withIdentifier: "detailPokemon", sender: nil)
  }
  
}
