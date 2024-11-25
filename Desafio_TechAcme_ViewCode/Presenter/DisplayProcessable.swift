//
//  DisplayProcessable.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation

protocol Displayer: AnyObject {
	var isLoading: Bool { get set }
	var errorMessage: String? { get set }
	
	func setElements()
}

protocol RepositoryDisplayer: AnyObject, Displayer {
	var repositories: [Repository] { get set }
	func displayRepositories()
	func fetchRepositories()
}

protocol PullRequestDisplayer: AnyObject, Displayer {
	var repository: Repository { get set }
	var pullRequests: [PullRequest] { get set }
	func displayPullRequests() 
	func fetchPullRequests()
}

