//
//  SlateEncoder.swift
//  slate
//
//  Created by Paul Kim on 2/2/20.
//  Copyright © 2020 Paul Kim. All rights reserved.
//

import Foundation

public struct SlateEncoder {
    
    public static func string(with editor: SlateEditor) throws -> String {
        let data = try JSONEncoder().encode(editor)
        guard let dataString = String(data: data, encoding: .utf8) else {
            throw SlateEncoderError.stringEncoding
        }
        let string = dataString.replacingOccurrences(of: "\\/", with: "/")
        return string
    }
    
    public static func string(with nodes: [SlateNode]) throws -> String {
        let data = try JSONEncoder().encode(nodes)
        guard let dataString = String(data: data, encoding: .utf8) else {
            throw SlateEncoderError.stringEncoding
        }
        let string = dataString.replacingOccurrences(of: "\\/", with: "/")
        return string
    }
    
}

public enum SlateEncoderError: Error {

    case stringEncoding

}
