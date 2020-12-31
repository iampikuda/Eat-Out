//
//  HomeViewController.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    private let screenSize: CGSize
    private let viewModel: HomeViewModelProtocol

    private let navLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()

    private let searchController = UISearchController(searchResultsController: nil)

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 40, right: 0)
        return collectionView
    }()

    private let sortView: SortView

    private let cellIdentifier = "main-collection-cell"

    init(
        viewModel: HomeViewModelProtocol,
        sortViewModel: SortViewModelProtocol,
        screenSize: CGSize = UIScreen.main.bounds.size
    ) {
        self.screenSize = screenSize
        self.viewModel = viewModel
        sortView = SortView(viewModel: sortViewModel)
        super.init(nibName: nil, bundle: nil)

        viewModel.realmDelegate = self
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupSortCollectionView()
        setupMainCollectionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sortView.initialize()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = UIColor.white
        navBar?.topItem?.title = ""
        navBar?.setBackgroundImage(nil, for: .default)
        navBar?.shadowImage = UIImage()
        navBar?.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor.white
        navLabel.font = UIFont.boldSystemFont(ofSize: 17)
        let attString = NSMutableAttributedString().withAttributes(
            text: String().timeOfDayString,
            textColor: UIColor.black,
            font: UIFont.boldSystemFont(ofSize: 17)
        ).appendStringWithAttributes(
            text: " Dami",
            textColor: .primary,
            font: UIFont.boldSystemFont(ofSize: 17)
        )

        navLabel.attributedText = attString

        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: navLabel)
    }

    func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
    }

    func setupSortCollectionView() {
        view.addSubview(sortView)
        sortView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }

        sortView.delegate = self
    }

    func setupMainCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(sortView.snp.bottom)
        }

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchedText = searchController.searchBar.text else { return }
        viewModel.filterText = searchedText
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            as? HomeCollectionViewCell else {
                return UICollectionViewCell()
        }

        cell.restuarant = viewModel.restuarantAt(indexPath)
        cell.delegate = self
        return cell
    }
}

extension HomeViewController: SortDelegate {
    func sortBy(_ sorter: Sorter) {
        viewModel.sorter = sorter
        viewModel.ascendingOrder = false
        collectionView.reloadData()
    }

    func changeOrder() {
        viewModel.ascendingOrder.toggle()
        collectionView.reloadData()
    }
}

extension HomeViewController: RealmUpdateDelegate {
    func gotInitialUpdate() {
        collectionView.reloadData()
    }

    func reloadEverything() {
        collectionView.reloadData()
    }

    func gotError(_ error: Error) {
        showErrorAlertFor(errorMessage: error.localizedDescription)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
        ) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: 300)
    }
}

extension HomeViewController: CellDelegate {
    func favourited(restuarant: Restuarant) {
        viewModel.favouriteResturant(restuarant)
    }
}
