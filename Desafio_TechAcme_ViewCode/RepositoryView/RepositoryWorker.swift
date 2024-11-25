//
//  RepositoryWorker.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation

// example links:
// https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1
// https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc

class RepositoryWorker: RepositoryWorkerProtocol {
	func fetchRepositories(request: RepositoryWebAccess.Request) async throws -> RepositoryWebAccess.Response {
		var url: URL? = nil
		
		if let order = request.order {
			url = URL(string: "https://api.github.com/search/repositories?q=\(request.q)&sort=\(request.sort)&order=\(order)")
		}
		if let page = request.page {
			url = URL(string: "https://api.github.com/search/repositories?q=\(request.q)&sort=\(request.sort)&page=\(page)")
		}
		
		guard let url = url else { throw URLError(.badURL) }
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw URLError(.badServerResponse)
		}
		
		return try JSONDecoder().decode(RepositoryWebAccess.Response.self, from: data)
	}

}
