//
//  SwipingController.swift
//  AutoLayoutOnlyCode
//
//  Created by takeru on 2018/10/16.
//  Copyright © 2018 takeru. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController {

    private var previousButton: UIButton!
    private var nextButton: UIButton!
    private var pageControl: UIPageControl!
    private var buttonsStackView: UIStackView!

    private var pages = [Page]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        setData()
    }

    private func setData() {
        let page1 = Page(image: #imageLiteral(resourceName: "bear_first"), header: "First Page", body: "firstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirstfirst")
        let page2 = Page(image: #imageLiteral(resourceName: "heart_second"), header: "Second Page", body: "secondsecondsecondsecondsecondsecondsecondsecondsecondsecondsecondsecondsecondsecondsecondsecondsecondsecondsecond")
        let page3 = Page(image: #imageLiteral(resourceName: "leaf_third"), header: "Third Page", body: "thirdthirdthirdthirdthirdthirdthirdthirdthirdthirdthirdthirdthirdthirdthirdthirdthirdthirdthirdthirdthird")
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)

        pageControl.numberOfPages = pages.count
    }

    private func setupView() {
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: PageCell.description())

        previousButton = UIButton()
        previousButton.setTitle("PREV", for: .normal)
        previousButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        previousButton.setTitleColor(.gray, for: .normal)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        view.addSubview(previousButton)

        nextButton = UIButton()
        nextButton.setTitle("NEXT", for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitleColor(.red, for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        view.addSubview(nextButton)

        pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.currentPage = 0
        view.addSubview(pageControl)

        buttonsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        view.addSubview(buttonsStackView)
    }

    private func setupConstraint() {
        buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        buttonsStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        buttonsStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        buttonsStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCell.description(), for: indexPath) as! PageCell
        cell.setData(page: pages[indexPath.row])
        return cell
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }

    @objc private func previousButtonTapped() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    @objc private func nextButtonTapped() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension SwipingController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
