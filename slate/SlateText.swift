//
//  SlateText.swift
//  slate
//
//  Created by Paul Kim on 2/2/20.
//  Copyright © 2020 Paul Kim. All rights reserved.
//

import Foundation
import UIKit

public enum SlateTextStyle {

    case bold(Bool)
    case italic(Bool)
    case strikethrough(Bool)
    case underline(Bool)
    
    private enum CodingKeys: String, CodingKey {
        case bold
        case italic
        case strikethrough = "strike"
        case underline
    }

}

extension SlateTextStyle: Equatable {
    
    public static func == (lhs: SlateTextStyle, rhs: SlateTextStyle) -> Bool {
        switch (lhs, rhs) {
        case (let .bold(isLHSBold), let .bold(isRHSBold)):
            return isLHSBold == isRHSBold
        case (let .italic(isLHSItalic), let .bold(isRHSItalic)):
            return isLHSItalic == isRHSItalic
        case (let .strikethrough(isLHSStrikethrough), let .bold(isRHSStrikethrough)):
            return isLHSStrikethrough == isRHSStrikethrough
        case (let .underline(isLHSUnderline), let .underline(isRHSUnderline)):
            return isLHSUnderline == isRHSUnderline
        default:
            return false
        }
    }
    
}

public struct SlateText: SlateTextProtocol {

    public let text: String
    public let styles: [SlateTextStyle]
    
    public init(text: String, styles: [SlateTextStyle]) {
        self.text = text
        self.styles = styles
    }

    private enum CodingKeys: String, CodingKey {

        case text
        case bold
        case italic
        case strikethrough = "strike"
        case underline

    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)

        // If a key for a given style exists and the value is true, add the style
        var styles: [SlateTextStyle] = []
        if let isBold = try? container.decodeIfPresent(Bool.self, forKey: .bold),
            isBold {
            styles.append(.bold(isBold))
        }
        if let isItalic = try? container.decodeIfPresent(Bool.self, forKey: .italic),
            isItalic {
            styles.append(.italic(isItalic))
        }
        if let isUnderline = try? container.decodeIfPresent(Bool.self, forKey: .underline),
            isUnderline {
            styles.append(.underline(isUnderline))
        }
        if let isStrikethrough = try? container.decodeIfPresent(Bool.self, forKey: .strikethrough),
            isStrikethrough {
            styles.append(.strikethrough(isStrikethrough))
        }
        self.styles = styles
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try styles.forEach { (style) in
            switch style {
            case .bold(let isBold):
                try container.encode(isBold, forKey: .bold)
            case .italic(let isItalic):
                try container.encode(isItalic, forKey: .italic)
            case .underline(let isUnderline):
                try container.encode(isUnderline, forKey: .underline)
            case .strikethrough(let isStrikethrough):
                try container.encode(isStrikethrough, forKey: .strikethrough)
            }
        }
    }

}

extension SlateTextProtocol {

    public func attributedText(with baseAttributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let workingText = NSMutableAttributedString(string: text)
        guard !text.isEmpty else {
            return workingText
        }

        // Get the range for the full string.
        let range = NSRange(location: 0, length: workingText.length)

        // Set text attributes.
        let textAttributes = self.textAttributes(with: baseAttributes)
        workingText.setAttributes(textAttributes, range: range)
        return workingText
    }

    private func textAttributes(with baseAttributes: [NSAttributedString.Key: Any]) -> [NSAttributedString.Key: Any] {
        var attributes = [NSAttributedString.Key: Any]()

        // Add baseAttributes to working copy.
        attributes.merge(baseAttributes) { $1 }

        // Add other attributes set in node to working copy.
        if styles.contains(.underline(true)) {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        if styles.contains(.strikethrough(true)) {
            attributes[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
        }

        // Add traited font to working copy.
        attributes[.font] = font(with: baseAttributes)

        return attributes
    }

    private func font(with baseAttributes: [NSAttributedString.Key: Any]) -> UIFont {
        // If no base font provided, default to .body.
        let baseFont = (baseAttributes[.font] as? UIFont) ?? UIFont.systemFont(ofSize: 16)
        let symbolicTraits = fontSymbolicTraits(with: baseFont)

        // Find symbolic traited font, else return the base font.
        if let fontDescriptor = baseFont.fontDescriptor.withSymbolicTraits(symbolicTraits) {
            return UIFont(descriptor: fontDescriptor, size: baseFont.pointSize)
        } else {
            return baseFont
        }
    }

    private func fontSymbolicTraits(with baseFont: UIFont) -> UIFontDescriptor.SymbolicTraits {
        var traits = UIFontDescriptor.SymbolicTraits()

        // Add base font symbolic traits to working copy.
        traits.insert(baseFont.fontDescriptor.symbolicTraits)

        // Add other traits set in node.
        if styles.contains(.bold(true)) {
            traits.insert(.traitBold)
        }
        if styles.contains(.italic(true)) {
            traits.insert(.traitItalic)
        }
        return traits
    }

}
