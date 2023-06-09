//
//  CellShadowView.swift
//  JokeList
//
//  Created by Ashok Rawat on 09/06/23.
//

import UIKit

class CellShadowView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
    
    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        setupBorder()
    }
    
    private func setupBorder() {
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
