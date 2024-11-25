//
//  PullRequestInteractor.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation

class PullRequestInteractor: BusinessPullRequest {
	
	var presenter: PullRequestPresenterProtocol?
	var worker: PullRequestWorkerProtocol
	
	var pullRequestResponse: PullRequestWebAccess.Response?
	
	init(presenter: PullRequestPresenterProtocol, worker: PullRequestWorkerProtocol = PullRequestWorker()) {
		self.presenter = presenter
		self.worker = worker
	}
	
	func startFetchingPullRequests(request: PullRequestWebAccess.Request) {
		Task {
			self.pullRequestResponse = try await self.worker.fetchPullRequests(request: request)
			self.presenter?.convertPullRequestResponseToViewModel(response: self.pullRequestResponse)
		}
	}
	
}
