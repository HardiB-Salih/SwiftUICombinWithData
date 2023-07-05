//
//  CustomLink.swift
//  SwiftUICombinWithData
//
//  Created by HardiB.Salih on 6/29/23.
//

import SwiftUI

struct CustomLink<Content: View>: View {
    let urlString: String
    let content: Content

    init(urlString: String, @ViewBuilder content: () -> Content) {
        self.urlString = urlString
        self.content = content()
    }

    var body: some View {
        if let url = URL(string: urlString) {
            Link(destination: url) {
                content
            }
        } else {
            content
        }
    }
}

