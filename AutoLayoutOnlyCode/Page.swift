//
//  Page.swift
//  AutoLayoutOnlyCode
//
//  Created by takeru on 2018/10/16.
//  Copyright © 2018 takeru. All rights reserved.
//

import UIKit

struct Page {

    let image: UIImage
    let header: String
    let body: String

    init(image: UIImage, header: String, body: String) {
        self.image = image
        self.header = header
        self.body = body
    }
}

