//
//  SlateNode.swift
//  slate
//
//  Created by Paul Kim on 2/2/20.
//  Copyright © 2020 Paul Kim. All rights reserved.
//

import Foundation

public enum SlateNode {

// `Element` nodes (container nodes which have semantic meaning in your domain)
    case paragraph(SlateParagraphElement)
    case title(SlateTitleElement)
    case blockQuote(SlateBlockQuoteElement)
    case codeBlock(SlateCodeBlockElement)
    case bulletedList(SlateBulletedListElement)
    case orderedList(SlateOrderedListElement)
    case listItem(SlateListItemElement)
    case separator(SlateSeparatorElement)
    case image(SlateImageElement)
    case video(SlateVideoElement)
    case tweet(SlateTweetElement)
    case link(SlateLinkElement)

// `Text` node (leaf-level nodes which contain the document's text)
    case text(SlateText)

    enum TypeKey: String, CodingKey {
        case type
    }

    public func attributedText(with baseAttributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        
        switch self {
        case .paragraph(let paragraph):
            return paragraph.attributedText(with: baseAttributes)
        case .title(let title):
            return title.attributedText(with: baseAttributes)
        case .blockQuote(let blockQuote):
            return blockQuote.attributedText(with: baseAttributes)
        case .codeBlock(let codeBlock):
            return codeBlock.attributedText(with: baseAttributes)
        case .bulletedList(let bulletedList):
            return bulletedList.attributedText(with: baseAttributes)
        case .orderedList(let orderedList):
            return orderedList.attributedText(with: baseAttributes)
        case .listItem(let listItem):
            return listItem.attributedText(with: baseAttributes)
        case .separator(let separator):
            return separator.attributedText(with: baseAttributes)
        case .image(let image):
            return image.attributedText(with: baseAttributes)
        case .video(let video):
            return video.attributedText(with: baseAttributes)
        case .tweet(let tweet):
            return tweet.attributedText(with: baseAttributes)
        case .link(let link):
            return link.attributedText(with: baseAttributes)
        case .text(let text):
            return text.attributedText(with: baseAttributes)
        }
    }

    public var text: String {
        switch self {
        case .paragraph(let paragraph):
            return paragraph.text
        case .title(let title):
            return title.text
        case .blockQuote(let blockQuote):
            return blockQuote.text
        case .codeBlock(let codeBlock):
            return codeBlock.text
        case .bulletedList(let bulletedList):
            return bulletedList.text
        case .orderedList(let orderedList):
            return orderedList.text
        case .listItem(let listItem):
            return listItem.text
        case .separator(let separator):
            return separator.text
        case .image(let image):
            return image.text
        case .video(let video):
            return video.text
        case .tweet(let tweet):
            return tweet.text
        case .link(let link):
            return link.text
        case .text(let text):
            return text.text
        }
    }

    public var imageURLs: [URL]? {
        switch self {
        case .paragraph(let paragraph):
            return paragraph.imageURLs
        case .title(let title):
            return title.imageURLs
        case .blockQuote(let blockQuote):
            return blockQuote.imageURLs
        case .codeBlock(let codeBlock):
            return codeBlock.imageURLs
        case .bulletedList(let bulletedList):
            return bulletedList.imageURLs
        case .orderedList(let orderedList):
            return orderedList.imageURLs
        case .listItem(let listItem):
            return listItem.imageURLs
        case .separator(let separator):
            return separator.imageURLs
        case .image(let image):
            return image.imageURLs
        case .video(let video):
            return video.imageURLs
        case .tweet(let tweet):
            return tweet.imageURLs
        case .link(let link):
            return link.imageURLs
        case .text:
            return nil
        }
    }

}

extension SlateNode: Codable {
    
    public init(from decoder: Decoder) throws {
        let typeContainer = try decoder.container(keyedBy: TypeKey.self)
        let type = try typeContainer.decodeIfPresent(SlateElementType.self, forKey: .type)

        // Decode the node by mapping the type to the correct decodable struct by inference
        let singleValueContainer = try decoder.singleValueContainer()

        switch type {
        case .paragraph:
            self = .paragraph(try Self.decode(container: singleValueContainer))
        case .title:
            self = .title(try Self.decode(container: singleValueContainer))
        case .image:
            self = .image(try Self.decode(container: singleValueContainer))
        case .blockQuote:
            self = .blockQuote(try Self.decode(container: singleValueContainer))
        case .codeBlock:
            self = .codeBlock(try Self.decode(container: singleValueContainer))
        case .listItem:
            self = .listItem(try Self.decode(container: singleValueContainer))
        case .bulletedList:
            self = .bulletedList(try Self.decode(container: singleValueContainer))
        case .orderedList:
            self = .orderedList(try Self.decode(container: singleValueContainer))
        case .video:
            self = .video(try Self.decode(container: singleValueContainer))
        case .tweet:
            self = .tweet(try Self.decode(container: singleValueContainer))
        case .link:
            self = .link(try Self.decode(container: singleValueContainer))
        case .separator:
            self = .separator(try Self.decode(container: singleValueContainer))
        case .none:
            self = .text(try Self.decode(container: singleValueContainer))
        }
    }
    
    public func encode(to encoder: Encoder) throws {

        switch self {
        case .paragraph(let paragraph):
            return try paragraph.encode(to: encoder)
        case .title(let title):
            return try title.encode(to: encoder)
        case .blockQuote(let blockQuote):
            return try blockQuote.encode(to: encoder)
        case .codeBlock(let codeBlock):
            return try codeBlock.encode(to: encoder)
        case .bulletedList(let bulletedList):
            return try bulletedList.encode(to: encoder)
        case .orderedList(let orderedList):
            return try orderedList.encode(to: encoder)
        case .listItem(let listItem):
            return try listItem.encode(to: encoder)
        case .separator(let separator):
            return try separator.encode(to: encoder)
        case .image(let image):
            return try image.encode(to: encoder)
        case .video(let video):
            return try video.encode(to: encoder)
        case .tweet(let tweet):
            return try tweet.encode(to: encoder)
        case .link(let link):
            return try link.encode(to: encoder)
        case .text(let text):
            return try text.encode(to: encoder)
        }
    }
    
    private static func decode<T: SlateNodeProtocol & Decodable>(container: SingleValueDecodingContainer) throws -> T {
        return try container.decode(T.self)
    }
    
}


public struct SlateNodeFactory {
    
    public static func paragraphNode(with nodes: [SlateNode]) -> SlateNode {
        let paragraph = SlateParagraphElement(children: nodes)
        return .paragraph(paragraph)
    }
    
    public static func textNode(for text: String, styles: [SlateTextStyle]) -> SlateNode {
        let text = SlateText(text: text, styles: styles)
        return .text(text)
    }
    
}
