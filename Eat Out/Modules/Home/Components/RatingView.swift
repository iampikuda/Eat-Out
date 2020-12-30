//
//  RatingView.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit
import SnapKit

final class RatingView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .primary
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(imageName: .star)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .primary
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubviews([label, imageView])
        label.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(imageView.snp.left)
        }

        imageView.snp.makeConstraints { (make) in
            make.bottom.top.right.equalTo(self)
            make.width.equalTo(imageView.snp.height)
        }
    }

    func setRatingTo(_ rating: Float) {
        label.text = String(format: "%.1f", rating)
    }
}
