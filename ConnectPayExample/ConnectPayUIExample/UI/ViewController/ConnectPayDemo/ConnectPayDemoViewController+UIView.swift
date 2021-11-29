//
//  ConnectPayDemoViewController+UIView.swift
//  ConnectPayExample
//
//  Created by 김진규 on 2021/06/03.
//

import UIKit

extension ConnectPayDemoViewController {
    class ViewHolder {
        enum Constants {
            static let buttonHeight: CGFloat = 56
            
            static let backgroundColor: UIColor = {
                if #available(iOS 13.0, *) {
                    return UIColor(dynamicProvider: { collection in
                       switch collection.userInterfaceStyle {
                       case .dark:
                           return .black
                       default:
                           return .white
                       }
                   })
                } else {
                    return .white
                }
            }()
            static let buttonNormalBackgroundColor = UIColor(red: 35.0 / 255.0, green: 102.0 / 255.0, blue: 209.0 / 255.0, alpha: 1.0)
            static let buttonHighlightedBackgroundColor = UIColor(red: 35.0 / 255.0, green: 102.0 / 255.0, blue: 209.0 / 255.0, alpha: 0.8)
        }
        let refreshControl = UIRefreshControl()
        let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            return UICollectionView(frame: .zero, collectionViewLayout: layout)
        }()
        let button = UIButton()
        let safeAreaBotomInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        
        func installView(on view: UIView) {
            installCollectionView(on: view)
            installButton(on: view)
        }
        
        private func installCollectionView(on view: UIView) {
            collectionView.addSubview(refreshControl)
            
            collectionView.backgroundColor = Constants.backgroundColor
            collectionView.contentInset.bottom = Constants.buttonHeight + safeAreaBotomInset
            
            view.addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
        private func installButton(on view: UIView) {
            button.setTitle("결제", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.setBackgroundImage(UIImage.image(fromColor: Constants.buttonNormalBackgroundColor), for: .normal)
            button.setBackgroundImage(UIImage.image(fromColor: Constants.buttonHighlightedBackgroundColor), for: .highlighted)
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: safeAreaBotomInset / 2, right: 0)
            
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                button.heightAnchor.constraint(equalToConstant: Constants.buttonHeight + safeAreaBotomInset)
            ])
        }
    }
}
