//
//  WorkingProcessable.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation

protocol RepositoryWorkerProtocol: AnyObject {
	func fetchRepositories(request: RepositoryWebAccess.Request) async throws -> RepositoryWebAccess.Response
}

protocol PullRequestWorkerProtocol: AnyObject {
	func fetchPullRequests(request: PullRequestWebAccess.Request) async throws -> PullRequestWebAccess.Response
}
