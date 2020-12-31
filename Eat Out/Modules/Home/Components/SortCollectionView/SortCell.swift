//
//  SortCell.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit
import SnapKit

final class SortCell: UICollectionViewCell {

    private let content = CircularView()

    override var isSelected: Bool {
        didSet {
            if isSelected {
                content.backgroundColor = .primary
                label.textColor = .white
            } else {
                content.backgroundColor = .lightGray
                label.textColor = .black
            }
        }
    }

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        backgroundColor = .white
        addSubviews([content, label])
        content.snp.makeConstraints { (make) in
            make.left.equalTo(label).offset(-4)
            make.right.equalTo(label).offset(4)
            make.top.equalTo(label).offset(-4)
            make.bottom.equalTo(label).offset(4)
        }
        label.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.9)
        }
        content.backgroundColor = .lightGray
        label.textColor = .black
    }

    func bindData(_ text: String) {
        label.text = text
    }
}

class CircularView: UIView {
    override var bounds: CGRect {
        didSet {
            guard oldValue != bounds else { return }
            self.layer.cornerRadius = self.frame.size.height / 2.0
        }
    }
}
