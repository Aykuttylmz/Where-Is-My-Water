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
    var neighborhoodsArray: [String] = []
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue
        return collectionView
    }()
    
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WIMWNeighborhoodCell.self, forCellWithReuseIdentifier: WIMWNeighborhoodCell.reuseID )
        
    }
    
    
    func configureStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 16
        verticalStackView.distribution = .fill
        verticalStackView.backgroundColor = .gray
        verticalStackView.layer.cornerRadius = 20
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.addArrangedSubview(districtLabel)
        horizontalStackView.addArrangedSubview(dateLabel)
        
        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(collectionView)
        verticalStackView.addArrangedSubview(descriptionLabel)
        
        view.addSubview(verticalStackView)
    }
    
    
    func configureUI() {
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            
            self.collectionView.heightAnchor.constraint(equalToConstant: 50),
            self.collectionView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            
            horizontalStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: padding),
            horizontalStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: -padding),
            horizontalStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let formattedDate = formatDate(date: outage.KesintiTarihi)
        districtLabel.font = UIFont.boldSystemFont(ofSize: 20)
        districtLabel.text = outage.IlceAdi
        dateLabel.text = "Kesinti tarihi: \(formattedDate)"
        descriptionLabel.text = outage.Aciklama
        
    }
    
    
    func formatDate(date: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputDateFormatter.timeZone = .current
        
        if let date = inputDateFormatter.date(from: date) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            return outputDateFormatter.string(from: date)
        } else {
            return "N/A"
        }
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
