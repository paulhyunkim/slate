//
//  ViewController.swift
//  slate
//
//  Created by Paul Kim on 2/2/20.
//  Copyright © 2020 Paul Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postData = PostContent.testData

        let slateNodes: [SlateNode]
        do {
            slateNodes = try SlateDecoder.nodes(with: postData)
            print(slateNodes.count)
            let data = try JSONEncoder().encode(slateNodes)
            let string = String(data: data, encoding: .utf8)?.replacingOccurrences(of: "\\/", with: "/")
            print(string == postData)
        } catch {
            print(error)
        }

        let hello = SlateNodeFactory.textNode(for: "Hello", styles: [.bold(true)])
        let world = SlateNodeFactory.textNode(for: "world", styles: [.underline(true)])
        let paragraph = SlateNodeFactory.paragraphNode(with: [hello, world])
        print(try? SlateEncoder.string(with: [paragraph]))
    }


}

