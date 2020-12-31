//
//  NSMutableAttributedString+Utils.swift
//  Eat Out
//
//  Created by Damisi Pikuda on 30/12/2020.
//

import UIKit

extension NSMutableAttributedString {
    /// Creates an attributed string with color, font, and (optional) - letter spacing
    ///
    /// - warning: The returned string is not localized.
    /// - returns: NSMutableAttributedString with color, font, and spacing
    @discardableResult
    func withAttributes(
        text: String,
        textColor: UIColor,
        font: UIFont,
        letterSpacing: CGFloat = 1.0
    ) -> NSMutableAttributedString {

        let normal = NSMutableAttributedString(string: text)

        let attributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.foregroundColor: textColor,
             NSAttributedString.Key.font: font,
             NSAttributedString.Key.kern: letterSpacing]

        normal.addAttributes(attributes, range: NSRange(location: 0, length: normal.length))

        return NSMutableAttributedString(string: text, attributes: attributes)
    }

    /// Appends an attributed string with attributes
    ///
    /// - warning: The returned string is not localized.
    /// - returns: NSMutableAttributedString with attended attributed string
    @discardableResult
    func appendStringWithAttributes(
        text: String,
        textColor: UIColor,
        font: UIFont,
        letterSpacing: CGFloat = 1.0
    ) -> NSMutableAttributedString {

        let attribStr = NSMutableAttributedString().withAttributes(
            text: text,
            textColor: textColor,
            font: font,
            letterSpacing: letterSpacing
        )

        append(attribStr)
        return self
    }

    /// Creates an attributed string with attributes and ParagraphStyle
    //
    /// - warning: The returned string is not localized.
    /// - warning: ParagraphStyle text alignment supersedes label text alignment!
    /// - returns: NSMutableAttributedString with color, font, and spacing, and paragraph style
    @discardableResult
    func withAttributes(
        text: String,
        textColor: UIColor,
        font: UIFont,
        letterSpacing: CGFloat = 1.0,
        paragraphLineHeightMultiple: CGFloat,
        paragraphLineSpacing: CGFloat = 0.0,
        textAlignment: NSTextAlignment = NSTextAlignment.left
    ) -> NSMutableAttributedString {

        let normal = NSMutableAttributedString(string: text)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = paragraphLineSpacing
        paragraphStyle.lineHeightMultiple = paragraphLineHeightMultiple
        paragraphStyle.alignment = textAlignment

        let attributes: [NSAttributedString.Key: Any] =
            [NSAttributedString.Key.foregroundColor: textColor,
             NSAttributedString.Key.font: font,
             NSAttributedString.Key.kern: letterSpacing,
             NSAttributedString.Key.paragraphStyle: paragraphStyle]

        normal.addAttributes(attributes, range: NSRange(location: 0, length: normal.length))

        return NSMutableAttributedString(string: text, attributes: attributes)
    }
}
