//
//  SlateNodeFactory.swift
//  Slate
//
//  Created by Paul Kim on 2/4/20.
//  Copyright © 2020 Paul Kim. All rights reserved.
//

import Foundation
import SwiftyAttributes

public struct SlateNodeFactory {

    public static func paragraphNode(with nodes: [SlateNode]) -> SlateNode {
        let paragraph = SlateParagraphElement(children: nodes)
        return .paragraph(paragraph)
    }

    public static func textNode(for text: String, styles: [SlateTextStyle]) -> SlateNode {
        let text = SlateText(text: text, styles: styles)
        return .text(text)
    }

    public static func paragraphNode(with attributedString: NSAttributedString) {
        attributedString.enumerateSwiftyAttributes(in: 0..<attributedString.length) { (attributes, range, _) in
            print(attributes)
        }
    }
}
