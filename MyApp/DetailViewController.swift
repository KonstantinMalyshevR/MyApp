//
//  DetailViewController.swift
//  MyApp
//
//  Created by Konstantin Malyshev on 10/10/2019.
//  Copyright © 2019 Konstantin Malyshev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var news: NewsObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = news?.title
        view.backgroundColor = .white

        var textView = UITextView()
        view.addSubview(textView)
        
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true

        textView.textAlignment = .justified
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 18)
        textView.text = news?.detail
    }
    
}
