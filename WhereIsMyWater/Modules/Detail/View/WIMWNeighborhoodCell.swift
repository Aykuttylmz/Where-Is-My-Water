//
//  WIMWNeighborhoodCell.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 31.01.2025.
//

import UIKit

class WIMWNeighborhoodCell: UICollectionViewCell {
    
    static let reuseID = "WIMWNeighborhoodCell"
    
    var neighborhoodNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureLabel() {
        neighborhoodNameLabel.textAlignment = .center
        neighborhoodNameLabel.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        neighborhoodNameLabel.textColor = .label
        neighborhoodNameLabel.backgroundColor = .systemGray6
        neighborhoodNameLabel.layer.cornerRadius = 12
        neighborhoodNameLabel.layer.masksToBounds = true
        neighborhoodNameLabel.numberOfLines = 1
        
        neighborhoodNameLabel.layer.borderWidth = 1
        neighborhoodNameLabel.layer.borderColor = UIColor.tertiaryLabel.cgColor
        neighborhoodNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(neighborhoodNameLabel)
    }
    
    
    func set(name: String) {
        self.neighborhoodNameLabel.text = name
    }
    
    
    func configureUI() {
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            neighborhoodNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            neighborhoodNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            neighborhoodNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            neighborhoodNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
    }
    
}

