//
//  ViewController.swift
//  MyApp
//
//  Created by Konstantin Malyshev on 10/10/2019.
//  Copyright © 2019 Konstantin Malyshev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let detailViewController = DetailViewController()
    private var newsTableView: UITableView = UITableView()
    private var newsArray: [NewsObject] = []
    private var myParser: XMLParserManager?
    private var dataService: DataService?
    private let pageLimit = 10
    private var pageNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        dataService = DataService()
        dataService?.start()

        navigationItem.title = "Lenta.ru Новости"
        view.backgroundColor = .white
        view.addSubview(newsTableView)

        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.backgroundColor = .clear
        newsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        newsTableView.estimatedRowHeight = 80.0
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        newsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        newsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true

        loadData()
    }

    func loadData() {
        if let data = dataService?.getData(page: pageNumber, limit: pageLimit) {
            pageNumber += 1
            newsArray.append(contentsOf: data)
        }
        newsTableView.reloadData()
    }

    //MARK: - TableView
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        if indexPath.row + 1 == newsArray.count {
            loadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.textLabel?.text = newsArray[indexPath.row].title
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = .systemFont(ofSize: 18)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        detailViewController.news = newsArray[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

