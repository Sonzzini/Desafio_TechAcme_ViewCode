//
//  PresentationProcessable.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 19/11/24.
//

import Foundation

protocol RepositoryPresenterProtocol: AnyObject {
	func convertRepositoryResponseToViewModel(response: RepositoryWebAccess.Response?)
}

protocol PullRequestPresenterProtocol: AnyObject {
	func convertPullRequestResponseToViewModel(response: PullRequestWebAccess.Response?)
}
