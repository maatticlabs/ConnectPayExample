//
//  PayMethodCell.swift
//  ConnectPayExample
//
//  Created by 김진규 on 2021/06/07.
//

import UIKit

final class PayMethodCell: UICollectionViewCell {
    enum Constants {
        // 3273dc
        static let selectedColor: UIColor = UIColor(
            red: 50.0 / 255.0,
            green: 115.0 / 255.0,
            blue: 220.0 / 255.0,
            alpha: 1
        )
        static let deselectedColor: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor(dynamicProvider: { traitCollection -> UIColor in
                    switch traitCollection.userInterfaceStyle {
                    case .dark:
                        return UIColor(
                            red: 10.0 / 255.0,
                            green: 10.0 / 255.0,
                            blue: 10.0 / 255.0,
                            alpha: 0.7
                        )
                    default:
                        return UIColor(
                            red: 245.0 / 255.0,
                            green: 245.0 / 255.0,
                            blue: 245.0 / 255.0,
                            alpha: 0.7
                        )
                    }
                })
            } else {
                return UIColor(
                    red: 245.0 / 255.0,
                    green: 245.0 / 255.0,
                    blue: 245.0 / 255.0,
                    alpha: 0.7
                )
            }
        }()
        
        static let cornerRadius: CGFloat = 8.0
    }
    
    let container = UIView()
    
    let vendorContainer = UIView()
    let vendorLabel = UILabel()
    let idContainer = UIView()
    let idLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 4)
        container.layer.shadowRadius = 6
        container.layer.shadowOpacity = 0.2
        container.layer.cornerRadius = Constants.cornerRadius
        
        vendorContainer.layer.cornerRadius = Constants.cornerRadius
        vendorContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
        vendorContainer.backgroundColor = Constants.deselectedColor
        
        container.addSubview(vendorContainer)
        container.addSubview(idContainer)
        vendorContainer.translatesAutoresizingMaskIntoConstraints = false
        idContainer.translatesAutoresizingMaskIntoConstraints = false
        vendorContainer.isUserInteractionEnabled = true
        idContainer.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            vendorContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            vendorContainer.topAnchor.constraint(equalTo: container.topAnchor),
            vendorContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            idContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            idContainer.topAnchor.constraint(equalTo: vendorContainer.bottomAnchor),
            idContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            idContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        vendorLabel.font = .systemFont(ofSize: 18, weight: .bold)
        vendorLabel.numberOfLines = 0
        idLabel.font = .systemFont(ofSize: 16)
        
        vendorContainer.addSubview(vendorLabel)
        idContainer.addSubview(idLabel)
        
        vendorLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vendorLabel.leadingAnchor.constraint(equalTo: vendorContainer.leadingAnchor, constant: 24),
            vendorLabel.topAnchor.constraint(equalTo: vendorContainer.topAnchor, constant: 24),
            vendorLabel.trailingAnchor.constraint(equalTo: vendorContainer.trailingAnchor, constant: -24),
            vendorLabel.bottomAnchor.constraint(equalTo: vendorContainer.bottomAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: idContainer.leadingAnchor, constant: 16),
            idLabel.topAnchor.constraint(equalTo: idContainer.topAnchor, constant: 16),
            idLabel.trailingAnchor.constraint(equalTo: idContainer.trailingAnchor, constant: -16),
            idLabel.bottomAnchor.constraint(equalTo: idContainer.bottomAnchor, constant: -16)
        ])
    }
    
    func bind(_ payMethod: PayMethodItem, isSelected: Bool) {
        vendorLabel.text = payMethod.vendorText
        idLabel.text = payMethod.idText

        vendorLabel.textColor = isSelected ? .white : .black
        vendorContainer.backgroundColor = isSelected ? Constants.selectedColor : Constants.deselectedColor
    }
}
