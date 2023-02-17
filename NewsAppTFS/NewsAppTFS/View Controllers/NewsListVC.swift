//
//  NewsListVC.swift
//  NewsAppTFS
//
//  Created by Мустафа Натур on 03.02.2023.
//

import UIKit

class NewsListVC: UIViewController {

    private let myRefreshControll = UIRefreshControl()
    private var tableView = UITableView()
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [Article]()
    private var searchController = UISearchController(searchResultsController: nil)

    
    
    @objc private func updateTable(sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getData()
            self.myRefreshControll.endRefreshing()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        confinfigureNewsListVC()
        configureTableView()
        getData()
        
        configureSearchbar()
    }
    
    private func getData() {

        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let newArticles):
                self?.articles.removeAll()
                self?.viewModels.removeAll()
                self?.articles = newArticles
                self?.viewModels = newArticles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title, imageURL: URL(string: $0.urlToImage ?? ""), reviews:Int.random(in: 10000...100000))
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.callAlert(title: "Ops...", message: "You must be connected to Wi-Fi or a cellular network")
                    print(error)
                    return
                }
            }
        }
    }
    
    func callAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let resetButton = UIAlertAction(title: "Reset", style: .default) { (action) in DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.getData()
            self.myRefreshControll.endRefreshing()
        }}
        alert.addAction(resetButton)
        self.present(alert, animated: true, completion: nil)
    }

    private func confinfigureNewsListVC() {
        title = "News"
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 140
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.setConstrains(to: view)
        myRefreshControll.addTarget(self, action: #selector(updateTable(sender:)), for: .valueChanged)
        tableView.addSubview(myRefreshControll)
    }
    
   private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureSearchbar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }

}


extension NewsListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        cell.set(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = NewsExtendedVC()
        vc.article = articles[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        APICaller.shared.searchStories(with: text) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title, imageURL: URL(string: $0.urlToImage ?? ""), reviews:Int.random(in: 10000...100000))
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.searchController.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}
