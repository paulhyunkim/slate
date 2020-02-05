//
//  ViewController.swift
//  slate
//
//  Created by Paul Kim on 2/2/20.
//  Copyright © 2020 Paul Kim. All rights reserved.
//

import UIKit
import SwiftyAttributes

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let postData = PostContent.testData
//
//        let slateNodes = try? SlateDecoder.nodes(with: postData)
//        print(slateNodes!.count)
//
//        let slateNodesString = try? SlateEncoder.string(with: slateNodes!)
//        print(slateNodesString!)
//        print(slateNodesString == postData)
//
//        let hello = SlateNodeFactory.textNode(for: "Hello", styles: [.bold(true)])
//        let world = SlateNodeFactory.textNode(for: "world", styles: [.underline(true)])
//        let paragraph = SlateNodeFactory.paragraphNode(with: [hello, world])
//        print(try? SlateEncoder.string(with: [paragraph]))

        let helloWorld = "Hello".withAttributes([.font(.systemFont(ofSize: 12, weight: .regular))])
            + "world".withAttributes([.font(.systemFont(ofSize: 12, weight: .bold)), .underlineStyle(.single)])
            + "!".withFont(.italicSystemFont(ofSize: 12))
            + " ".attributedString
            + "link".withAttributes([.font(.systemFont(ofSize: 12)), .link(URL(string: "www.google.com")!)])

        SlateNodeFactory.paragraphNode(with: helloWorld)
    }


}

