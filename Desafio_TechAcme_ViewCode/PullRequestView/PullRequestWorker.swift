//
//  PullRequestWorker.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation

// example link:
// https://api.github.com/repos/vsouza/awesome-ios/pulls?state=closed

class PullRequestWorker: PullRequestWorkerProtocol {
	
	func fetchPullRequests(request: PullRequestWebAccess.Request) async throws -> PullRequestWebAccess.Response {
		guard let url = URL(string: "https://api.github.com/repos/\(request.owner)/\(request.repository)/pulls?state=\(request.state)") else { throw URLError(.badURL) }
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw URLError(.badServerResponse)
		}
		
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		
		return try decoder.decode(PullRequestWebAccess.Response.self, from: data)
	}

}


class MockPullRequestWorker: PullRequestWorkerProtocol {
	
	func fetchPullRequests(request: PullRequestWebAccess.Request) async throws -> PullRequestWebAccess.Response {
		guard let url = Bundle.main.url(forResource: "MockPullRequestAPIResponse", withExtension: "json") else { throw URLError(.fileDoesNotExist) }
		
		let data = try Data(contentsOf: url)
		
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		
		return try decoder.decode(PullRequestWebAccess.Response.self, from: data)
	}
	
}
