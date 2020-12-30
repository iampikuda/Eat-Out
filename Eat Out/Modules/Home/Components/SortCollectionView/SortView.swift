//
//  SortView.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit
import SnapKit

final class SortView: UIView {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return collectionView
    }()

    private let cellIdentifier = "Sort-cell"

    private var currentIndexPath = IndexPath(row: 0, section: 0)

    private let itemSize: CGSize
    private let viewModel: SortViewModelProtocol

    init(viewModel: SortViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)

        setupViews()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        setupCollectionView()
    }

    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SortCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
}

extension SortView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension SortView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            as? SpeedCell else {
                return UICollectionViewCell()
        }

        cell.bindData(viewModel.textFor(indexPath))
        cell.setupTheme()
        return cell
    }
}
