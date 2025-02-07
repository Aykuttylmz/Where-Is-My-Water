//
//  WIMWOutageDetailVC.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 30.01.2025.
//

import UIKit

class WIMWOutageDetailVC: UIViewController {
    
    var outage: Outage
    
    let stackView = UIStackView()
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
        configureCollectionView()
        configureStackView()
        configureViewController()
        configureUI()
    }
    
    
    init(outage: Outage) {
        self.outage = outage
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureViewController() {
        title = outage.IlceAdi.capitalized
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    func configureStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.axis = .vertical
        stackView.backgroundColor = .systemBackground
        stackView.distribution = .fillProportionally
        stackView.layer.cornerRadius = 5
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.clipsToBounds = true
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        stackView.setCustomSpacing(10, after: dateLabel)
    }
    
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WIMWNeighborhoodCell.self, forCellWithReuseIdentifier: WIMWNeighborhoodCell.reuseID )
        
    }
    
    
    func configureUI() {
        
        let padding: CGFloat = 16

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            collectionView.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
        
        let formattedDate = outage.KesintiTarihi.formatDate()
        dateLabel.text = "Kesinti tarihi: \(formattedDate)"
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.text = "Açıklama: \n \(outage.Aciklama.lowercased().capitalizeFirstLetter()) "
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
