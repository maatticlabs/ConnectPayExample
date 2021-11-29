//
//  CollectionHeaderView.swift
//  ConnectPayExample
//
//  Created by 김진규 on 2021/06/03.
//

import UIKit

final class CollectionHeaderCell: UICollectionReusableView {
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var handler: (() -> Void)? {
        didSet {
            self.settingButton.isHidden = handler == nil
            self.settingButton.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    let titleLabel = UILabel()
    let settingButton = UIButton()
    private func setup() {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        settingButton.setTitle("결제 설정", for: .normal)
        settingButton.backgroundColor = .lightGray
        settingButton.isHidden = true
        
        addSubview(titleLabel)
        addSubview(settingButton)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            settingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            settingButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
 
    @objc func handleAction(_ sender: Any) {
        handler?()
    }
}
