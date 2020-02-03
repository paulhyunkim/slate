//
//  SlateProtocols.swift
//  slate
//
//  Created by Paul Kim on 2/2/20.
//  Copyright © 2020 Paul Kim. All rights reserved.
//

import Foundation

public protocol SlateNodeProtocol: Codable {

    // An Element node can traverse its children to generate text from leaf text nodes.
    // A Text node can generate text from its text property.
    func attributedText(with baseAttributes: [NSAttributedString.Key: Any]) -> NSAttributedString
    var text: String { get }

}

// Root-level `Editor` node that contains the entire document's content.
public protocol SlateEditorProtocol: SlateNodeProtocol {

    var children: [SlateNode] { get }

}

extension SlateEditorProtocol {

    // Default implementation (most nodes will use the default implementation)
    public func attributedText(with baseAttributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        return children.compactMap({ $0.attributedText(with: baseAttributes) }).joined(separator: "")
    }

    public var text: String {
        return children.compactMap({ $0.text }).joined()
    }

    public var imageURLs: [URL] {
        return children.compactMap({ $0.imageURLs }).flatMap({ $0 })
    }

}

// Middle-layer container `Element` nodes which have semantic meaning in Voice documents.
/// Slate element nodes must have children of other Slate nodes. A Slate element is a node.
public protocol SlateElementProtocol: SlateNodeProtocol {

    var type: SlateElementType { get }
    var children: [SlateNode] { get }

}

extension SlateElementProtocol {

    // Default implementation (most nodes will use the default implementation)
    public func attributedText(with baseAttributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        return children.compactMap({ $0.attributedText(with: baseAttributes) }).joined(separator: "")
    }

    public var text: String {
        return children.compactMap({ $0.text }).joined()
    }

    public var imageURLs: [URL] {
        return children.compactMap({ $0.imageURLs }).flatMap({ $0 })
    }
    
}

// Leaf-level `Text` nodes which contain the document's text.
/// Slate text nodes must have a string and an array of styles. A Slate text is a node.
public protocol SlateTextProtocol: SlateNodeProtocol {

    var text: String { get }
    var styles: [SlateTextStyle] { get }

}

extension SlateTextProtocol {

    public var imageURLs: [URL] {
        return []
    }

}
