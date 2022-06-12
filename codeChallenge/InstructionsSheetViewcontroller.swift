//
//  InstructionsSheetViewcontroller.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/11/22.
//

import UIKit

class InstructionsSheetViewcontroller: UIViewController {
    
    var instructions: String?

    private let instructionsLabel: UILabel = {
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
        self.instructionsLabel.text = instructions
        view.addSubview(instructionsLabel)
        
        NSLayoutConstraint.activate([
            self.instructionsLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            self.instructionsLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            self.instructionsLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            self.instructionsLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
}
