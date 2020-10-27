import FinnhubSwift
import UIKit

extension CompanySymbol {
    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else { return true }
        if filterText.isEmpty { return true }
        let lowercasedFilter = filterText.lowercased()
        return symbol.lowercased().contains(lowercasedFilter) || description.lowercased().contains(lowercasedFilter)
    }
}

class SymbolsViewModel: ObservableObject {
    @Published var symbols: [CompanySymbol] = []
    @Published var loading: Bool = false

    func filteredSymbols(with filter: String? = nil, limit: Int? = nil) -> [CompanySymbol] {
        let filtered = symbols.filter { $0.contains(filter) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }

    func fetchSymbols() {
        loading = true
        FinnhubClient.symbols(exchange: .unitedStates) { [weak self] result in
            self?.loading = false
            switch result {
            case let .success(data):
                self?.symbols = data
            case .failure(.invalidData):
                self?.symbols = []
            case .failure(.networkFailure(_)):
                self?.symbols = []
            }
        }
    }
}
