//
//  CitiesListViewController.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import UIKit

final class CitiesListViewController: UIViewController, StoryboardLoadable, CitiesListViewInput {
    
    @IBOutlet private weak var citiesTableView: UITableView!
    
    private var cities = [City]()
    private var filteredCities = [City]()
    private let searchController = UISearchController()
    
    var presenter: CitiesListViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        title = "Cities"
        
        configureCitiesTableView()
        configureSearchBar()
        
        presenter?.viewDidFinishLoading()
    }
    
    func setCities(cities: [City]) {
        self.cities = cities
    }
}

// MARK: - Private
private extension CitiesListViewController {
    
    func configureCitiesTableView() {
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        citiesTableView.register(CitiesListTableViewCell.nib(), forCellReuseIdentifier: CitiesListTableViewCell.identifier)
    }
    
    func configureSearchBar() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

// MARK: - TableView delegate / datasource
extension CitiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return filteredCities.count
        } else {
            return cities.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = citiesTableView.dequeueReusableCell(withIdentifier: CitiesListTableViewCell.identifier) as? CitiesListTableViewCell else {
            return UITableViewCell()
        }
        
        let city: City?
        if searchController.isActive {
            city = filteredCities[indexPath.row]
        } else {
            city = cities[indexPath.row]
        }
        
        let imageHelper: ImageURLHelper
        if (indexPath.row + 1) % 2 == 0 {
            imageHelper = .even
        } else {
            imageHelper = .odd
        }
        
        cell.vmodel = CitiesListTableViewCell.ViewModel(city: city!, imageURLString: imageHelper.imageURL)
        
        return cell
    }
    
}

extension CitiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = searchController.isActive ? filteredCities[indexPath.row] : cities[indexPath.row]
        presenter?.viewDidSelectCity(city: city)
    }
}

// MARK: - UISearchResultsUpdating
extension CitiesListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        filteredCities = cities.filter { $0.name.lowercased().hasPrefix(text.lowercased()) }
        citiesTableView.reloadData()
    }
}
