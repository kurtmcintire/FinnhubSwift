import FinnhubSwift
import UIKit

enum Section: CaseIterable {
    case main
}

class SymbolsDataSource: UICollectionViewDiffableDataSource<Section, CompanySymbol> {
    init(ownedCollectionView: UICollectionView) {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CompanySymbol> { cell, _, symbol in
            var contentConfiguration = UIListContentConfiguration.cell()
            contentConfiguration.text = symbol.description
            contentConfiguration.secondaryText = symbol.symbol
            cell.contentConfiguration = contentConfiguration
            cell.accessories = [.disclosureIndicator()]
        }

        super.init(collectionView: ownedCollectionView) { (collectionView, indexPath, identifier) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }

    func update(_ newSymbols: [CompanySymbol]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CompanySymbol>()
        snapshot.appendSections([.main])
        snapshot.appendItems(newSymbols)
        apply(snapshot, animatingDifferences: true)
    }
}
