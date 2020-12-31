//
//  ImageTextLabel.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit

struct ImageDetails {
    let imageName: ImageName
    let imageHeight: CGFloat
    let imageOffset: CGFloat
}

struct TextDetails {
    let text: String
    let textOffset: CGFloat
    let textFont: UIFont
    let textColor: UIColor
}

struct ImageTextDetails {
    let imageDetails: ImageDetails
    let textDetails: TextDetails
}

final class ImageTextLabel: UILabel {
    func setupLabel(withDetails details: ImageTextDetails) {
        let attributedString = NSMutableAttributedString()

        self.text = details.textDetails.text
        self.font = details.textDetails.textFont
        self.textColor = details.textDetails.textColor
        self.textAlignment = .left

        let additionalText = NSMutableAttributedString().withAttributes(
            text: details.textDetails.text,
            textColor: self.textColor,
            font: details.textDetails.textFont,
            paragraphLineHeightMultiple: 0.8,
            paragraphLineSpacing: 5.0
        )

        attributedString.append(additionalText)

        attributedString.addAttributes(
            [NSAttributedString.Key.baselineOffset: details.textDetails.textOffset],
            range: NSRange(location: 0, length: additionalText.length)
        )

        let image = UIImage(imageName: details.imageDetails.imageName)?.withRenderingMode(.alwaysTemplate)
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.setImageHeight(height: details.imageDetails.imageHeight)

        let imageString = NSMutableAttributedString(attachment: attachment)
        imageString.addAttributes(
            [NSAttributedString.Key.baselineOffset: details.imageDetails.imageOffset],
            range: NSRange(location: 0, length: imageString.length)
        )

        attributedString.append(imageString)

        self.attributedText = attributedString
        self.textAlignment = textAlignment

    }
}

extension NSTextAttachment {
    func setImageHeight(height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height

        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
    }
}
