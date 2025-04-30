//
//  RepoViewModel.swift
//  copticOrphans
//
//  Created by Michael Hany on 30/04/2025.
//

import Foundation
import Combine

class RepositoriesViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var searchQuery: String = ""
    @Published var isLoading: Bool = false
    @Published var page: Int = 1
    @Published var hasMore: Bool = true
    @Published var errorMessage: String?
    @Published var showErrorAlert: Bool = false
    
    private let service = Service()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newQuery in
                self?.resetAndSearch()
            }
            .store(in: &cancellables)
    }
    
    func resetAndSearch() {
        repositories = []
        page = 1
        hasMore = true
        search()
    }
    
    func search() {
        guard !isLoading, hasMore, !searchQuery.isEmpty else { return }
        isLoading = true
        errorMessage = nil
        
        service.fetchRepositories(query: searchQuery, page: page) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let repos):
                    self?.repositories += repos
                    self?.hasMore = !repos.isEmpty
                    self?.page += 1
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showErrorAlert = true
                }
            }
        }
    }
}
