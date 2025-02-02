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
    
    let districtLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.lineBreakMode = .byClipping
        return label
    }()

    let outageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "drop.degreesign.slash.fill")
        imageView.tintColor = .systemOrange
        return imageView
    }()
    
    let neighborhoodsLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    func set(outage: Outage) {
        districtLabel.text = outage.IlceAdi
        neighborhoodsLabel.text = outage.Mahalleler.capitalized
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
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 18
        
        NSLayoutConstraint.activate([
            outageImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            outageImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            outageImageView.heightAnchor.constraint(equalToConstant: 40),
            outageImageView.widthAnchor.constraint(equalToConstant: 45),
            
            districtLabel.leadingAnchor.constraint(equalTo: outageImageView.trailingAnchor, constant: padding),
            districtLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            districtLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            neighborhoodsLabel.leadingAnchor.constraint(equalTo: districtLabel.leadingAnchor),
            neighborhoodsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            neighborhoodsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
            
        ])
    }
    
}

