//
//  WIMWOutageDetailVC.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 30.01.2025.
//

import UIKit

class WIMWOutageDetailVC: UIViewController {
    
    var outage: Outage
    
    let verticalStackView = UIStackView()
    let horizontalStackView = UIStackView()
    
    let districtLabel = UILabel()
    let neighborhoodsLabel = UILabel()
    let dateLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let collectionView = UICollectionView()
    
    var neighborhoodsArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        neighborhoodsArray = outage.Mahalleler.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces)}
        configureCollectionView()
        configureStackView()
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
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView.collectionViewLayout = layout
    
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WIMWNeighborhoodCell.self, forCellWithReuseIdentifier: WIMWNeighborhoodCell.reuseID )
        collectionView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
    
    
    func configureStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 16
        verticalStackView.distribution = .fill
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.addArrangedSubview(districtLabel)
        horizontalStackView.addArrangedSubview(dateLabel)
        
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(collectionView)
        verticalStackView.addArrangedSubview(descriptionLabel)
        
        view.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureUI() {
        
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
        
        districtLabel.text = outage.IlceAdi
        dateLabel.text = outage.KesintiTarihi
        descriptionLabel.text = outage.Aciklama
        
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
