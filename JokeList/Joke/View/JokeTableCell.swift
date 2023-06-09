//
//  JokeTableCell.swift
//  JokeList
//
//  Created by Ashok Rawat on 09/06/23.
//

import UIKit

class JokeTableCell: UITableViewCell {
    let titleLabel = UILabel()
    let oddRowColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
    let shadowView = CellShadowView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        self.selectionStyle = .none
        shadowView.addSubview(titleLabel)
        contentView.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: -12)
        ])
    }
    
    func configureCell(_ text: String, _ indexPath: IndexPath) {
        let isOddRow = (indexPath.row  % 2 == 0)
        self.titleLabel.text = text
        self.titleLabel.numberOfLines = 0
        self.titleLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        self.shadowView.backgroundColor = isOddRow ? oddRowColor  : .white
    }
}
