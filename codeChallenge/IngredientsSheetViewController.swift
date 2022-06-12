//
//  IngredientsSheetViewController.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/11/22.
//

import UIKit

class IngredientsSheetViewController: UIViewController {
    
    var ingredients: String?
    
    private let ingredientsLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 15)
            label.numberOfLines = 0
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.ingredientsLabel.text = ingredients        
        view.addSubview(ingredientsLabel)

        NSLayoutConstraint.activate([
            self.ingredientsLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            self.ingredientsLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            self.ingredientsLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.ingredientsLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}
