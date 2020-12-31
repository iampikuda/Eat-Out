//
//  HomeCollectionViewCell.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit
import SnapKit

protocol CellDelegate: class {
    func favourited(restuarant: Restuarant)
}

final class HomeCollectionViewCell: UICollectionViewCell {
    weak var delegate: CellDelegate?

    override func prepareForReuse() {
        super.prepareForReuse()
        overlayView.isHidden = true
        statusView.isHidden = true
    }

    private let mainView = ShadowView()
    private let bottomView: UIView = {
        let view = UIView()
        view.addCorners(radius: 12, lr: true, ll: true)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        return view
    }()

    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.isHidden = true
        view.layer.cornerRadius = 12
        return view
    }()

    // to increase contact area
    private let favouriteButton = UIButton(type: .custom)
    private let statusView = StatusView()
    private let upperDetailView = UIView()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(imageName: .defaultLogo)
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        imageView.addCorners(radius: 12, tr: true, tl: true)
        return imageView
    }()

    private let heartImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(imageName: .heart)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .primary
        return imageView
    }()

    private let ratingView = ImageTextLabel()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()

    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    private let cellBottomView = CellBottomView()

    var restuarant: Restuarant? {
        didSet {
            bindData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(mainView)
        mainView.clipsToBounds = true

        mainView.snp.makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.84)
            make.centerX.centerY.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.95)
        }

        mainView.addSubviews([imageView, upperDetailView, favouriteButton, bottomView, overlayView, statusView])

        setupTop()
        setupBottom()

        overlayView.snp.makeConstraints { (make) in
            make.edges.equalTo(mainView)
        }

        statusView.snp.makeConstraints { (make) in
            make.left.top.equalTo(mainView)
            make.height.equalTo(30)
        }

        favouriteButton.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
    }

    private func setupTop() {
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(mainView)
            make.height.equalTo(mainView).multipliedBy(0.7)
        }

        upperDetailView.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.bottom.equalTo(imageView).offset(-5)
            make.height.equalTo(25)
            make.width.equalTo(imageView).multipliedBy(0.93)
        }

        upperDetailView.addSubviews([ratingView, heartImage])
        ratingView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(upperDetailView)
            make.width.equalTo(60)
        }

        heartImage.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(upperDetailView)
            make.width.equalTo(heartImage.snp.height)
        }

        favouriteButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(44)
            make.centerX.centerY.equalTo(heartImage)
        }
    }

    private func setupBottom() {
        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(mainView)
            make.top.equalTo(imageView.snp.bottom)
        }

        bottomView.backgroundColor = .white

        bottomView.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(bottomView)
            make.width.equalTo(bottomView).multipliedBy(0.93)
            make.height.equalTo(bottomView).multipliedBy(0.95)
        }

        bottomStackView.addArrangedSubviews([nameLabel, cellBottomView])

    }

    @objc private func favouriteButtonPressed() {
        guard let restuarant = restuarant else { return }
        self.delegate?.favourited(restuarant: restuarant)
    }

    private func bindData() {
        guard let restuarant = restuarant else { return }
        ratingView.setupLabel(
            withDetails: ImageTextDetails(
                imageDetails: ImageDetails(
                    imageName: .star,
                    imageHeight: 20,
                    imageOffset: -5.5
                ),
                textDetails: TextDetails(
                    text: "\(restuarant.rating)",
                    textOffset: -3,
                    textFont: UIFont.boldSystemFont(ofSize: 18),
                    textColor: .primary
                )
            )
        )
        heartImage.image = restuarant.isFavourited ?
            UIImage(imageName: .heartFilled)?.withRenderingMode(.alwaysTemplate) :
            UIImage(imageName: .heart)?.withRenderingMode(.alwaysTemplate)

        let attstring = NSMutableAttributedString()
            .withAttributes(
                text: restuarant.name,
                textColor: .black,
                font: UIFont.systemFont(ofSize: 18)
            ).appendStringWithAttributes(
                text: "· " + restuarant.costLevel.rawValue,
                textColor: UIColor.black.withAlphaComponent(0.4),
                font: UIFont.systemFont(ofSize: 18)
            )
        nameLabel.attributedText = attstring

        cellBottomView.setLabel(
            mininum: restuarant.minimumCost,
            delivery: restuarant.deliveryCost,
            distance: restuarant.distance
        )

        statusView.setStatus(restuarant.status)
        overlayView.isHidden = restuarant.status != .closed
    }
}
