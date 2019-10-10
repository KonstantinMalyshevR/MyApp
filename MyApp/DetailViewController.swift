//
//  DetailViewController.swift
//  MyApp
//
//  Created by Konstantin Malyshev on 10/10/2019.
//  Copyright © 2019 Konstantin Malyshev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Pfd"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        view.addSubview(textView)
        
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 18)
        textView.text = "ewefwfwefwe"
    }
    
}
