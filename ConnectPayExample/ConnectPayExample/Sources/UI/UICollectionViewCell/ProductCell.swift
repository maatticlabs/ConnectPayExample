//
//  ProductCell.swift
//  ConnectPayExample
//
//  Created by 김진규 on 2021/06/07.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    
    let container = UIView()
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let amountLabel = UILabel()
    let sizeLabel = UILabel()
    
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
        
        imageView.image = UIImage(named: "tee")
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        amountLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        sizeLabel.font = .systemFont(ofSize: 14)
        
        container.addSubview(imageView)
        container.addSubview(titleLabel)
        container.addSubview(amountLabel)
        container.addSubview(sizeLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24),
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 128),
            imageView.widthAnchor.constraint(equalToConstant: 128),
            imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            amountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24)
        ])
        
        NSLayoutConstraint.activate([
            sizeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            sizeLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24),
            sizeLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 4)
        ])
    }
    
    func bind(_ product: ProductItem) {
        titleLabel.text = product.title
        sizeLabel.text = product.sizeText
        amountLabel.text = product.amountText
    }
}

