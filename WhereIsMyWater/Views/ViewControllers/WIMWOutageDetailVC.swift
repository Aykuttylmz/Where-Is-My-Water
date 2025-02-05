//
//  WIMWOutageDetailVC.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 30.01.2025.
//

import UIKit

class WIMWOutageDetailVC: UIViewController {
    
    var outage: Outage
    
    let dateLabel = UILabel()
    lazy var neighborhoodsArray = outage.Mahalleler.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces)}
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = -10
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = outage.IlceAdi.capitalized
        configureCollectionView()
        configureUI()
    }
    
    
    init(outage: Outage) {
        self.outage = outage
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WIMWNeighborhoodCell.self, forCellWithReuseIdentifier: WIMWNeighborhoodCell.reuseID )
        
    }
    
    
    func configureUI() {
        
        view.addSubview(collectionView)
        view.addSubview(dateLabel)
        view.addSubview(descriptionLabel)
        
        let padding: CGFloat = 16

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
            
            dateLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            
           
        ])
        
        let formattedDate = outage.KesintiTarihi.formatDate()
        dateLabel.text = "Kesinti tarihi: \(formattedDate)"
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.text = outage.Aciklama.lowercased().capitalizeFirstLetter()
    }
    
    
}


extension WIMWOutageDetailVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return neighborhoodsArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WIMWNeighborhoodCell.reuseID, for: indexPath) as! WIMWNeighborhoodCell
        cell.set(name: neighborhoodsArray[indexPath.item])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let name = neighborhoodsArray[indexPath.item] // Get text
               
        let font = UIFont.systemFont(ofSize: 16, weight: .medium)
        let textAttributes = [NSAttributedString.Key.font: font]
        let textSize = (name as NSString).size(withAttributes: textAttributes)
        
        let horizontalPadding: CGFloat = 24
        let cellWidth = textSize.width + horizontalPadding
        let cellHeight: CGFloat = 40
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    
    
}
