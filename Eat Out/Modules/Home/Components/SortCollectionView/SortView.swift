//
//  SortView.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit
import SnapKit

protocol SortDelegate: class {
    func sortBy(_ sorter: Sorter)
    func changeOrder()
}

final class SortView: UIView {
    weak var delegate: SortDelegate?

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return collectionView
    }()

    private let cellIdentifier = "Sort-cell"

    private var selectedIndexPath = IndexPath(row: 0, section: 0)

    private let viewModel: SortViewModelProtocol

    init(viewModel: SortViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .white

        setupViews()
        #if DEBUG
        setupForUITest()
        #endif
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

    func initialize() {
        collectionView.selectItem(
            at: IndexPath(row: 0, section: 0),
            animated: false,
            scrollPosition: .centeredHorizontally
        )
    }
}

extension SortView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if selectedIndexPath == indexPath {
            self.delegate?.changeOrder()
        } else {
            self.delegate?.sortBy(viewModel.sortAt(indexPath))
        }
        selectedIndexPath = indexPath
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
            as? SortCell else {
                return UICollectionViewCell()
        }

        cell.bindData(viewModel.textAt(indexPath))
        #if DEBUG
        cell.accessibilityIdentifier = TestIdentifiers.sortCell(sorter: viewModel.sortAt(indexPath))
        #endif
        return cell
    }
}

extension SortView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = viewModel.textAt(indexPath).boundingRect(
            with: collectionView.frame.size,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)],
            context: nil
        ).width

        return CGSize(width: width + 5, height: collectionView.frame.size.height)
    }
}

#if DEBUG
private extension SortView {
    func setupForUITest() {
        collectionView.accessibilityIdentifier = TestIdentifiers.sortCollectionView.rawValue
    }
}
#endif
