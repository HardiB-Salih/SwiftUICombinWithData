//
//  FAQView.swift
//  SwiftUICombinWithData
//
//  Created by HardiB.Salih on 6/29/23.
//

import SwiftUI

struct FAQView: View {
    @State private var contentOffset = CGFloat(0)
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack(alignment: .top) {
            TraceableScrollView(offsetChanged: { offsetPoint in
                withAnimation(.easeIn){
                    contentOffset = offsetPoint.y
                }
            }) {
                content
            }
            
            VisualEffectBlur(blurStyle: .systemMaterial)
                .opacity(contentOffset < -16 ? 1 : 0)
                .ignoresSafeArea()
                .frame(height: 0)
            
        }.frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle("FAQ").font(.largeTitle)
            .background(Color("Background 2").edgesIgnoringSafeArea(.all))
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: backButton)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            ForEach(faqData, id: \.id) { faq in
                FAQRow(faq: faq)
            }
            
            Text("Have any question?")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .opacity(0.7)
            
            PrimaryButton().padding(.top)
        }
        .padding(.horizontal, 20)
    }
    
    var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 16, weight: .semibold))
                .frame(width: 24, height: 24)
        }
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}
