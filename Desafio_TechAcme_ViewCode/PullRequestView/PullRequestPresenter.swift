//
//  PullRequestPresenter.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation

class PullRequestPresenter: PullRequestPresenterProtocol {
	
	weak var pullRequestViewController: PullRequestDisplayer?
	
	init(pullRequestViewController: PullRequestDisplayer) {
		self.pullRequestViewController = pullRequestViewController
	}
	
	func convertPullRequestResponseToViewModel(response: PullRequestWebAccess.Response?) {
		guard let response = response else { return }
		
		let pullRequests: [PullRequest] = response.items.map { pr in
			return PullRequest(authorName: pr.user.login,
									 authorAvatarURL: pr.user.avatarURL,
									 title: pr.title,
									 body: pr.body,
									 createdAt: pr.createdAt,
									 closedAt: pr.closedAt)
		}
		
		pullRequestViewController?.pullRequests = pullRequests
		pullRequestViewController?.displayPullRequests()
	}
	
}
