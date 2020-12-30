//
//  CellBottomView.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit
import SnapKit

final class CellBottomView: UIStackView {

    private let minLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()

    private let deliveryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()

    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .equalCentering
        self.spacing = 20

        addArrangedSubviews([minLabel, deliveryLabel, distanceLabel])
    }

    func setLabel(mininum: Float, delivery: Float, distance: Float) {
        minLabel.text = "\(mininum)".replacingOccurrences(of: ".", with: ",") + " € min."

        let deliveryText = delivery == 0 ? "Free" : "\(delivery) €"
        deliveryLabel.text = deliveryText.replacingOccurrences(of: ".", with: ",") + " delivery"

        distanceLabel.text = "\(distance)".replacingOccurrences(of: ".", with: ",") + " meters"
    }
}
