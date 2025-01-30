//
//  WIMWOutageCell.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 30.01.2025.
//

import UIKit

class WIMWOutageCell: UITableViewCell {
    
    var cellSubViews = [UIView]()

    static let reuseID = "OutageCell"
    
    let outageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "drop.degreesign.slash.fill")
        return imageView
    }()
    
    let districtLabel = UILabel()
    let neighborhoodsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        cellSubViews = [outageImageView, districtLabel, neighborhoodsLabel]
        
        for view in cellSubViews {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            outageImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            outageImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            outageImageView.heightAnchor.constraint(equalToConstant: 60),
            outageImageView.widthAnchor.constraint(equalToConstant: 60),
            
            districtLabel.leadingAnchor.constraint(equalTo: outageImageView.trailingAnchor, constant: padding),
            districtLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            districtLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            neighborhoodsLabel.leadingAnchor.constraint(equalTo: districtLabel.leadingAnchor, constant: padding),
            neighborhoodsLabel.topAnchor.constraint(equalTo: districtLabel.bottomAnchor, constant: padding),
            neighborhoodsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
            
        ])
        
        
        
    }
    
}
