//
//  ConnectPayDemoViewController+UICollectionView.swift
//  ConnectPayExample
//
//  Created by 김진규 on 2021/06/03.
//

import UIKit

// MARK: - UICollectionView
extension ConnectPayDemoViewController {
    enum CollectionViewConstants {
        static let headerIdentifier = "CollectionHeader"
        static let productCellIdentifier = "ProductCell"
        static let destinationCellIdentifier = "DestinationCell"
        static let payMethodCellIdentifier = "PayMethodCell"
    }
    
    func setupCollectionView() {
        viewHolder.collectionView.delegate = self
        viewHolder.collectionView.dataSource = self
        
        setupRefreshControl()
        setupCollectionViewCells()
    }
    
    private func setupRefreshControl() {
        viewHolder.refreshControl.addTarget(self, action: #selector(changedRefreshControlValue(_:)), for: .valueChanged)
    }
    
    @objc private func changedRefreshControlValue(_ sender: Any) {
        if viewHolder.refreshControl.isRefreshing {
            refreshPayMethods()
            viewHolder.refreshControl.endRefreshing()
        }
    }
    
    private func setupCollectionViewCells() {
        viewHolder.collectionView.register(
            ProductCell.self,
            forCellWithReuseIdentifier: CollectionViewConstants.productCellIdentifier
        )
        viewHolder.collectionView.register(
            DestinationCell.self,
            forCellWithReuseIdentifier: CollectionViewConstants.destinationCellIdentifier
        )
        viewHolder.collectionView.register(
            PayMethodCell.self,
            forCellWithReuseIdentifier: CollectionViewConstants.payMethodCellIdentifier
        )
        viewHolder.collectionView.register(
            CollectionHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CollectionViewConstants.headerIdentifier
        )
    }
}

// MARK: - UICollectionViewDataSource
extension ConnectPayDemoViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemType = sections[indexPath.section].type
        switch itemType {
        case .product:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewConstants.productCellIdentifier, for: indexPath) as? ProductCell else { return ProductCell() }
            if let product = sections[indexPath.section].items[indexPath.item] as? ProductItem {
                cell.bind(product)
            }
            return cell
        case .destination:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewConstants.destinationCellIdentifier, for: indexPath) as? DestinationCell else { return DestinationCell() }
            if let destination = sections[indexPath.section].items[indexPath.item] as? DestinationItem {
                cell.bind(destination)
            }
            return cell
        case .payMethod:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewConstants.payMethodCellIdentifier, for: indexPath) as? PayMethodCell else { return PayMethodCell() }
            if let payMethod = sections[indexPath.section].items[indexPath.item] as? PayMethodItem {
                let isSelected: Bool = {
                    guard let method = payMethod.method else { return false }
                    return method.id == self.selectedPayableMethod?.id
                }()
                cell.bind(payMethod, isSelected: isSelected)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                    withReuseIdentifier: CollectionViewConstants.headerIdentifier,
                    for: indexPath) as? CollectionHeaderCell else { return CollectionHeaderCell() }
            header.title = sections[indexPath.section].title
            header.handler = sections[indexPath.section].handler
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension ConnectPayDemoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = sections[indexPath.section].items[indexPath.item] as? PayMethodItem else { return }
        if let method = item.method {
            self.selectedPayableMethod = method
            collectionView.reloadData()
        } else {
            didTapAddPaymentMethod(())
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ConnectPayDemoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemType = sections[indexPath.section].type
        switch itemType {
        case .product:
            return CGSize(width: UIScreen.main.bounds.width, height: 208)
        case .destination:
            var height: CGFloat = 32 + 48 + 4
            height += 34
            height += 17
            return CGSize(width: UIScreen.main.bounds.width, height: height)
        case .payMethod:
            var height: CGFloat = 32 + 48 + 32
            height += 24
            height += 20
            return CGSize(width: UIScreen.main.bounds.width, height: height)
        }
    }
}
