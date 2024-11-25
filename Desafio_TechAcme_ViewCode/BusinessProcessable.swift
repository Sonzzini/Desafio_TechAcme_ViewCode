//
//  BusinessProcessable.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation

protocol BusinessRepository: AnyObject {
	func startFetchingRepositories(request: RepositoryWebAccess.Request)
}

protocol BusinessPullRequest: AnyObject {
	func startFetchingPullRequests(request: PullRequestWebAccess.Request)
}
