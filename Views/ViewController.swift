//
//  ViewController.swift
//  M18homework
//
//  Created by Владимир Бурлинов on 11.09.2022.
//

import UIKit
import SnapKit

final class ViewControllerMain: UIViewController {
    
  //  var movies1 = [Country]()
        
    let networkDataFetcher = NetworkDataFetcher()
  
    var setData = [Film]()
    
    let press: ViewPresenterProtocol = ViewControllerPresenter()
    
    var searchResponse: Welcome? = nil
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let identifier = "cell"
  
    private var timer: Timer?
    
    private lazy var table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.separatorColor = .gray
        table.register(CustomCell.self, forCellReuseIdentifier: "customCell")
        return table
    }()
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Searh"
        
        press.setView(self)
        
        table.dataSource = self
        table.delegate = self
        
        setupSearchBar()
        setupView()
        setupConstraints()
        press.setupData(with: setData)
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
    private func setupView() {
        view.addSubview(table)
    }
    
    private func setupConstraints() {
        
        table.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}


extension ViewControllerMain: ModelViewControllerProtocol {
    func showAlert(title: String, message: String) {
        
    }
    
    
}
//MARK: - extension TableView

extension ViewControllerMain: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setData.count
        //press.numberOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell
        cell.configure(with: setData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieViewController()
        vc.indicator.startAnimating()
        guard let apiURL = URL(string: setData[indexPath.row].posterURL) else { return }
        
        vc.configure1(with: setData[indexPath.row])
        
        URLSession.shared.dataTask(with: apiURL) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                vc.imageView.image = UIImage(data: data)
                vc.indicator.stopAnimating()
            }
        }.resume()
     
        
        vc.title = searchResponse?.films[indexPath.row].nameRu
        tableView.reloadData()

        
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: -  extension SearchController
extension ViewControllerMain: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(searchText)"
        print(setData.count)
        //"https://www.omdbapi.com/?i=tt3896198&apikey=fded5355&s=\(searchText)" //"https://imdb-api.com/API/Search/k_a11p9jp6/\(searchText)"//Avatar""https://imdb-api.com/swagger/index.html"
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchData(urlString: urlString) { (searchResponse) in
                guard let searchResponse = searchResponse else { return }
                
                self.searchResponse = searchResponse
                self.setData.append(contentsOf: searchResponse.films)
                print("Count are: \(self.setData.count)")

                self.table.reloadData()
            }
        })
    }
}

extension ViewControllerMain: ViewProtocol {
    func reloadTable() {
        
    }
    
    
}
