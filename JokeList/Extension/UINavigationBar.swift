//
//  UINavigationBar.swift
//  JokeList
//
//  Created by Ashok Rawat on 08/06/23.
//

import UIKit

extension UINavigationBar {
    
    func customNavigationBar(title: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        let navigationItem = UINavigationItem(title: title)
        self.setItems([navigationItem], animated: false)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance
    }
    
    func updateNavigationConstraint(_ view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
