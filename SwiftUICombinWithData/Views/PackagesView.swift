//
//  PackagesView.swift
//  SwiftUICombinWithData
//
//  Created by HardiB.Salih on 6/29/23.
//

import SwiftUI

struct PackagesView: View {
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
            .navigationTitle("SwiftUI Packages").font(.largeTitle)
            .background(Color("Background 2").edgesIgnoringSafeArea(.all))
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: backButton)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text("This app was 100% made using SwiftUI. We’d like to thank these amazing Swift Packages for making our lives as creators easier.")
                .font(.subheadline)
                .opacity(0.7)
                .frame(maxWidth: .infinity, alignment:. leading)
                .fixedSize(horizontal: false, vertical: true)
            
            ForEach(packagesData, id: \.id) { package in
                PackageRow(package: package)
            }
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

struct PackagesView_Previews: PreviewProvider {
    static var previews: some View {
        PackagesView()
    }
}
