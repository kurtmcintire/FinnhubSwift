import UIKit

enum Section: CaseIterable {
    case main
}

class SymbolsDataSource: UICollectionViewDiffableDataSource<Section, SymbolViewModel> {
    init(ownedCollectionView: UICollectionView) {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SymbolViewModel> { cell, _, symbol in
            var contentConfiguration = UIListContentConfiguration.cell()
            contentConfiguration.text = symbol.text
            contentConfiguration.secondaryText = symbol.secondaryText
            cell.contentConfiguration = contentConfiguration
            cell.accessories = [.disclosureIndicator()]
        }

        super.init(collectionView: ownedCollectionView) { collectionView, indexPath, identifier -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
    }

    func update(_ newSymbols: [SymbolViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SymbolViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(newSymbols)
        apply(snapshot, animatingDifferences: true)
    }
}
