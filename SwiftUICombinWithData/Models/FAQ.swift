//
//  FAQ.swift
//  SwiftUICombinWithData
//
//  Created by HardiB.Salih on 6/29/23.
//

import Foundation

struct FAQ: Decodable, Identifiable {
    var id: Int
    var question: String
    var answer: String
}
