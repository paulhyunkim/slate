//
//  SlateDecoder.swift
//  slate
//
//  Created by Paul Kim on 2/2/20.
//  Copyright © 2020 Paul Kim. All rights reserved.
//

import Foundation

public struct SlateDecoder {

    public static func editor(with postContent: String) throws -> SlateEditor {
        guard let postData = postContent.data(using: .utf8) else {
            throw SlateDecoderError.dataEncoding
        }
        return try JSONDecoder().decode(SlateEditor.self, from: postData)
    }
    
    public static func nodes(with postContent: String) throws -> [SlateNode] {
        guard let postData = postContent.data(using: .utf8) else {
            throw SlateDecoderError.dataEncoding
        }
        return try JSONDecoder().decode([SlateNode].self, from: postData)
    }

}

public enum SlateDecoderError: Error {

    case dataEncoding

}
