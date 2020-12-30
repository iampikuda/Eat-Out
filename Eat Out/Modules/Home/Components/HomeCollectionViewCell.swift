//
//  HomeCollectionViewCell.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit
import SnapKit

final class HomeCollectionViewCell: UICollectionViewCell {
    private let mainView = ShadowView()
    private let bottomView = UIView()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(imageName: .defaultLogo)
        return imageView
    }()

    private let heartImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(imageName: .heart)?.withRenderingMode(.alwaysTemplate)
        imageView.isHidden = true
        imageView.tintColor = .primary
        return imageView
    }()

    private let ratingView = RatingView()

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
        mainView.snp.makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.84)
            make.centerX.centerY.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.9)
        }

        mainView.addSubviews([imageView, ratingView, heartImage, bottomView])
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(mainView)
            make.height.equalTo(mainView).multipliedBy(0.7)
        }

        ratingView.snp.makeConstraints { (make) in
            make.left.equalTo(imageView).offset(15)
            make.bottom.equalTo(imageView).offset(5)
            make.width.equalTo(80)
        }

        heartImage.snp.makeConstraints { (make) in
            make.right.equalTo(imageView).offset(-15)
            make.bottom.equalTo(ratingView)
            make.width.equalTo(44)
            make.height.equalTo(heartImage.snp.width)
        }

        bottomView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(mainView)
            make.top.equalTo(imageView.snp.bottom)
        }

        bottomView.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints { (make) in
            make.edges.equalTo(bottomView)
        }

        bottomStackView.addArrangedSubviews([nameLabel, cellBottomView])
    }

    private func bindData() {
        guard let restuarant = restuarant else { return }
        ratingView.setRatingTo(restuarant.rating)
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
    }
}
