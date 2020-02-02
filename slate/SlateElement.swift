//
//  SlateElement.swift
//  slate
//
//  Created by Paul Kim on 2/2/20.
//  Copyright © 2020 Paul Kim. All rights reserved.
//

import Foundation

/// Enumeration of all the element node types defined by Voice
public enum SlateElementType: String, Codable {

    case paragraph
    case title
    case image
    case blockQuote = "blockquote"
    case codeBlock = "code"
    case bulletedList = "list"
    case orderedList
    case video
    case tweet
    case link
    case listItem
    case separator

}

/// SlateBasicElement is a Slate node structure that only has children.
public struct SlateParagraphElement: SlateElementProtocol {
  
    public let type: SlateElementType = .paragraph
    public let children: [SlateNode]
    
    public init(children: [SlateNode]) {
        self.children = children
    }

//    public init(text: String) {
//        let text = SlateText(text: "hello", styles: [.bold(true)])
//        children = [SlateNode.text(text)]
//    }
}

public struct SlateTitleElement: SlateElementProtocol {
  
    public let type: SlateElementType = .title
    public let children: [SlateNode]
    
    public init(children: [SlateNode]) {
        self.children = children
    }

}

public struct SlateBlockQuoteElement: SlateElementProtocol {
  
    public let type: SlateElementType = .blockQuote
    public let children: [SlateNode]
    
    public init(children: [SlateNode]) {
        self.children = children
    }

}

public struct SlateCodeBlockElement: SlateElementProtocol {
  
    public let type: SlateElementType = .codeBlock
    public let children: [SlateNode]
    
    public init(children: [SlateNode]) {
        self.children = children
    }

}

public struct SlateBulletedListElement: SlateElementProtocol {
  
    public let type: SlateElementType = .bulletedList
    public let children: [SlateNode]
    
    public init(children: [SlateNode]) {
        self.children = children
    }

}

public struct SlateOrderedListElement: SlateElementProtocol {
  
    public let type: SlateElementType = .orderedList
    public let children: [SlateNode]
    
    public init(children: [SlateNode]) {
        self.children = children
    }

}

public struct SlateListItemElement: SlateElementProtocol {
  
    public let type: SlateElementType = .listItem
    public let children: [SlateNode]
    
    public init(children: [SlateNode]) {
        self.children = children
    }

}

public struct SlateSeparatorElement: SlateElementProtocol {
  
    public let type: SlateElementType = .separator
    public let children: [SlateNode]
    
    public init(children: [SlateNode]) {
        self.children = children
    }

}

public struct SlateImageElement: SlateElementProtocol {

    public let type: SlateElementType = .image
    public let hash: String
    public let children: [SlateNode]

    // To satisfy SlateNodeProtocol
    public var imageURLs: [URL] {
        return [url].compactMap { $0 }
    }

    public var url: URL? {
        guard let baseUrl = URL(string: "http://www.google.com") else {
            return nil
        }
        return baseUrl.appendingPathComponent(hash)
    }

}

public struct SlateTweetElement: SlateElementProtocol {

    public let type: SlateElementType = .tweet
    public let tweetId: String
    public let children: [SlateNode]

}

public struct SlateVideoElement: SlateElementProtocol {

    public let type: SlateElementType = .video
    public let url: URL
    public let children: [SlateNode]

}

public struct SlateLinkElement: SlateElementProtocol {

    public let type: SlateElementType = .link
    public let url: URL
    public let children: [SlateNode]

    private enum CodingKeys: String, CodingKey {
        case type
        case url = "href"
        case children
    }

    private var linkAttributes: [NSAttributedString.Key: Any] {
        return [.link: url.absoluteString]
    }

    // Links require a specific implementation for attributedText because they need additional
    // attributing to add a link attribute.
    public func attributedText(with baseAttributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let attributedString = children.compactMap({ $0.attributedText(with: baseAttributes) }).joined(separator: "")
        let workingString = NSMutableAttributedString(attributedString: attributedString)
        let range = NSRange(location: 0, length: workingString.length)
        workingString.addAttributes(linkAttributes, range: range)
        return workingString
    }
    
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
////        type = try container.decode(SlateElementType.self, forKey: .type)
//        url = try container.decode(URL.self, forKey: .url)
//        children = try container.decode([SlateNode].self, forKey: .children)
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(type, forKey: .type)
//        try container.encode(url, forKey: .url)
//        try container.encode(children, forKey: .children)
//    }

}
