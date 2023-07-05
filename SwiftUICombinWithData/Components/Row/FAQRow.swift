//
//  FAQRow.swift
//  SwiftUICombinWithData
//
//  Created by HardiB.Salih on 6/29/23.
//

import SwiftUI

struct FAQRow: View {
    var faq: FAQ
    var body: some View {
        VStack (alignment: .leading, spacing: 16.0){
            Text(faq.question)
                .font(.title3).bold()
            
            Text(faq.answer)
                .font(.subheadline)
                .opacity(0.7)
            
            Divider()
        }
    }
}

struct FAQRow_Previews: PreviewProvider {
    static var previews: some View {
        FAQRow(faq: faqData[0])
    }
}
