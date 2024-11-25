//
//  Desafio_TechAcme_ViewCodeTests.swift
//  Desafio_TechAcme_ViewCodeTests
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//
import Foundation
import Testing
@testable import Desafio_TechAcme_ViewCode

struct Desafio_TechAcme_ViewCodeTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
	
	@Test func pullRequestAPI() async throws {
		let request = PullRequestWebAccess.Request(owner: "Sonzzini", repository: "Sinale", state: "closed")
		
		let worker = PullRequestWorker()
		
		let response = try await worker.fetchPullRequests(request: request)
		
		for item in response.items {
			print("\(item.user.login): \(item.title)")
		}
		
		#expect(response.items.count > 0)
	}
	
	@Test func pullRequestAPISonzzini() async throws {
		
	}

}
