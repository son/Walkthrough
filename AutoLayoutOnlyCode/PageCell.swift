//
//  PageCell.swift
//  AutoLayoutOnlyCode
//
//  Created by takeru on 2018/10/16.
//  Copyright © 2018 takeru. All rights reserved.
//

import UIKit

final class PageCell: UICollectionViewCell {

    private var topImageContainerView: UIView!
    private var imageView: UIImageView!
    private var descriptionTextView: UITextView!
    private var previousButton: UIButton!
    private var nextButton: UIButton!
    private var buttonsStackView: UIStackView!
    private var pageControl: UIPageControl!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        topImageContainerView = UIView()
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topImageContainerView)

        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.addSubview(imageView)

        descriptionTextView = UITextView()
        descriptionTextView.textAlignment = .center
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.isUserInteractionEnabled = false
        addSubview(descriptionTextView)

    }

    private func setupConstraint() {
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1 / 2).isActive = true

        imageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 1 / 2).isActive = true

        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    func setData(page: Page) {
        imageView.image = page.image
        let attributedText = NSMutableAttributedString(
            string: page.header,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        )
        attributedText.append(NSAttributedString(
            string: "\n\n\n\(page.body)",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                         NSAttributedString.Key.foregroundColor: UIColor.gray]
        ))
        descriptionTextView.attributedText = attributedText
    }
}
