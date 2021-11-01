//
//  DestinationCell.swift
//  ConnectPayExample
//
//  Created by 김진규 on 2021/06/07.
//

import UIKit

final class DestinationCell: UICollectionViewCell {
    let container = UIView()
    
    let addressLabel = UILabel()
    let customerLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        container.backgroundColor = .white
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 4)
        container.layer.shadowRadius = 6
        container.layer.shadowOpacity = 0.2
        
        addressLabel.font = .systemFont(ofSize: 14, weight: .bold)
        addressLabel.numberOfLines = 0
        customerLabel.font = .systemFont(ofSize: 14)
        
        container.addSubview(addressLabel)
        container.addSubview(customerLabel)
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        customerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            addressLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 24),
            addressLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            customerLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            customerLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 4),
            customerLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -24),
            customerLabel.trailingAnchor.constraint(equalTo: addressLabel.trailingAnchor)
        ])
    }
    
    func bind(_ destination: DestinationItem) {
        addressLabel.text = destination.addressText
        customerLabel.text = destination.customerText
    }
}
