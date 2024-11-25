//
//  PullRequestTableViewCell.swift
//  Desafio_TechAcme_ViewCode
//
//  Created by Paulo Sonzzini Ribeiro de Souza on 25/11/24.
//

import Foundation
import UIKit

class PullRequestTableViewCell: UITableViewCell {
	static let identifier = "PullRequestTableViewCell"
	
	lazy var ownerImageView = UIImageView()
	lazy var ownerNameLabel = UILabel()
	lazy var titleLabel = UILabel()
	lazy var descriptionLabel = UILabel()
	
	private var imageSaveTask: URLSessionDataTask?
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(with pullRequest: PullRequest) {
		let numFormatter = NumberFormatter()
		numFormatter.numberStyle = .decimal
		
		ownerNameLabel.text = pullRequest.authorName
		titleLabel.text = pullRequest.title
		descriptionLabel.text = pullRequest.body
		
		if let url = URL(string: pullRequest.authorAvatarURL) {
			loadImage(from: url)
		}
	}
	
	private func loadImage(from url: URL) {
		if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
			ownerImageView.image = cachedImage
			return
		}
		
		imageSaveTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			guard let self = self,
					let data = data,
					let image = UIImage(data: data),
					error == nil
			else { return }
			
			ImageCache.shared.saveImage(image, forKey: url.absoluteString)
			
			DispatchQueue.main.async {
				self.ownerImageView.image = image
			}
		}
		imageSaveTask?.resume()
	}
	
	private func setUI() {
		contentView.addSubview(ownerImageView)
		contentView.addSubview(ownerNameLabel)
		contentView.addSubview(titleLabel)
		contentView.addSubview(descriptionLabel)
		
		ownerImageView.translatesAutoresizingMaskIntoConstraints = false
		ownerNameLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			ownerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			ownerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			ownerImageView.widthAnchor.constraint(equalToConstant: 25),
			ownerImageView.heightAnchor.constraint(equalToConstant: 25),
			
			ownerNameLabel.topAnchor.constraint(equalTo: ownerImageView.topAnchor),
			ownerNameLabel.leadingAnchor.constraint(equalTo: ownerImageView.trailingAnchor, constant: 10),
			
			titleLabel.topAnchor.constraint(equalTo: ownerImageView.bottomAnchor, constant: 10),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			
			descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
			descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			descriptionLabel.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}
