//
//  ViewController.swift
//  MyApp
//
//  Created by Konstantin Malyshev on 10/10/2019.
//  Copyright © 2019 Konstantin Malyshev. All rights reserved.
//

import UIKit

protocol MainViewControllerProtocol {
    func refreshTable()
}

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MainViewControllerProtocol {

    private var newsTableView: UITableView = UITableView()
    private var newsArray: [NewsObject] = []
    private var myParser: XMLParserManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Lenta.ru Новости"
        view.backgroundColor = .white
        view.addSubview(newsTableView)
    
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.backgroundColor = .clear
        newsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        newsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        newsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        loadData()
    }

    func loadData() {
        let url = URL(string: "https://lenta.ru/rss/news")!
        myParser = XMLParserManager()
        myParser?.controllerDelegate = self
        myParser?.startRequest(url)
    }

    func refreshTable() {
        if let parser = myParser {
            newsArray = parser.getNews()
        }
        newsTableView.reloadData()
    }

    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
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

        let vc = DetailViewController()
        vc.news = newsArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

