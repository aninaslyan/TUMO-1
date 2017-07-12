//
//  MyViewController.swift
//  TUMO
//
//  Created by Garric G. Nahapetian on 7/11/17.
//  Copyright © 2017 TUMO. All rights reserved.
//

import UIKit

class MyViewController: UITableViewController, UISearchBarDelegate {

    let searchController = UISearchController(searchResultsController: nil)

    let names = ["Garen", "Garric", "Hayk", "Ani", "Lilit"]

    var items: [String] = []

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            items = items.filter {
                $0.lowercased().contains(searchText.lowercased())
            }

            tableView.reloadData()
            searchController.dismiss(animated: true, completion: nil)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        reset()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            reset()
            searchController.dismiss(animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        items = names.sorted()

        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")

        let myBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.add,
            target: self,
            action: #selector(didTapAddButton))

        navigationItem.rightBarButtonItem = myBarButtonItem

        let resetButton = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(didTapResetButton))

        navigationItem.leftBarButtonItem = resetButton
    }

    func reset() {
        items = names.sorted()
        tableView.reloadData()
    }

    func didTapResetButton(sender: UIBarButtonItem) {
        reset()
    }

    func didTapAddButton(sender: UIBarButtonItem) {
        let newString = "Item \(names.count)"
        items.append(newString)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        viewController.title = items[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}














