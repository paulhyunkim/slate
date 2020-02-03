//
//  Extensions.swift
//  slate
//
//  Created by Paul Kim on 2/2/20.
//  Copyright © 2020 Paul Kim. All rights reserved.
//

import Foundation

extension NSAttributedString {

    public func split(separator: String) -> [NSAttributedString] {
        let input = self.string
        let separatedInput = input.components(separatedBy: separator)
        var output = [NSAttributedString]()
        var start = 0
        for component in separatedInput {
            let range = NSRange(location: start, length: component.utf16.count)
            let attribStr = self.attributedSubstring(from: range)
            output.append(attribStr)
            start += range.length + separator.count
        }
        return output
    }

    public func trimmingCharacters(in set: CharacterSet) -> NSAttributedString {
        let modifiedString = NSMutableAttributedString(attributedString: self)
        modifiedString.trimCharacters(in: set)
        return NSAttributedString(attributedString: modifiedString)
    }

}

extension Sequence where Iterator.Element: NSAttributedString {

    public func joined(separator: NSAttributedString) -> NSAttributedString {
        var isFirstElement = true
        return self.reduce(NSMutableAttributedString()) { result, element in
            if isFirstElement {
                isFirstElement = false
            } else {
                result.append(separator)
            }
            result.append(element)
            return result
        }
    }

    public func joined(separator: String) -> NSAttributedString {
        return joined(separator: NSAttributedString(string: separator))
    }

}

extension NSMutableAttributedString {
    
    public func trimCharacters(in set: CharacterSet) {
        var range = (string as NSString).rangeOfCharacter(from: set, options: .anchored)
        
        // Trim leading characters from character set.
        while range.location != NSNotFound {
            replaceCharacters(in: range, with: "")
            range = (string as NSString).rangeOfCharacter(from: set, options: .anchored)
        }
        
        // Trim trailing characters from character set.
        range = (string as NSString).rangeOfCharacter(from: set, options: [.anchored, .backwards])
        while range.location != NSNotFound {
            replaceCharacters(in: range, with: "")
            range = (string as NSString).rangeOfCharacter(from: set, options: [.anchored, .backwards])
        }
    }
    
}
