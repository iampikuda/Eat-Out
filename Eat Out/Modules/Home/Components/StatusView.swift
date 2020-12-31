//
//  StatusView.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 31/12/2020.
//

import UIKit
import SnapKit

final class StatusView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
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
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.6)
            make.width.equalTo(self).multipliedBy(0.8)
        }

        addCorners(radius: 12, tl: true)
    }

    func setStatus(_ status: Status) {
        label.text = status.text
        self.isHidden = status.isHidden
        backgroundColor = status.color
    }
}
