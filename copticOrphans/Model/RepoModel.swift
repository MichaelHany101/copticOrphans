//
//  Repo.swift
//  copticOrphans
//
//  Created by Michael Hany on 30/04/2025.
//

import Foundation

struct RepoSearchResponse: Decodable {
    let items: [Repository]
}

struct Repository: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let description: String?
    let html_url: String
}
