//
//  Service.swift
//  copticOrphans
//
//  Created by Michael Hany on 30/04/2025.
//

import Foundation
import Alamofire

class Service {
    func fetchRepositories(query: String, page: Int, completion: @escaping (Result<[Repository], Error>) -> Void) {
        let url = "https://api.github.com/search/repositories"
        let params: [String: Any] = [
            "q": query,
            "page": page,
            "per_page": 20
        ]

        AF.request(url, parameters: params)
            .validate()
            .responseDecodable(of: RepoSearchResponse.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result.items))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
