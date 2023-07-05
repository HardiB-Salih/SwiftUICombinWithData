//
//  CertificatesView.swift
//  SwiftUICombinWithData
//
//  Created by HardiB.Salih on 6/30/23.
//

import SwiftUI

struct CertificatesView: View {
    @StateObject var certificateVM =  CertificateViewModel()
    @StateObject var networkReachability = NetworkReachability()
    @State private var selection: Int = 0
    @State private var progressValue: Float = 0.5


    var body: some View {
        VStack {
            if networkReachability.reachable {
                if certificateVM.certificates.count > 0 {
                    TabView(selection: $selection) {
                        ForEach(certificateVM.certificates.indices, id: \.self) { index in
                            withAnimation (.easeIn){
                                CertificateCard(selection: $selection)
                                    .padding(8)
                                    .environmentObject(certificateVM)
                            }
                            
                        }
                    }.tabViewStyle(.page)
                } else {
                    ProgressView(value: progressValue)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white.opacity(0.7)))
                        .scaleEffect(2.0) // Increase the size by scaling
                }
                
            } else {
                Text("Please connect to the Internet to see your certificates.")
                    .font(.headline).fontWeight(.semibold).foregroundColor(.white.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }.background(AccountBackground())
    }
}

struct CertificatesView_Previews: PreviewProvider {
    static var previews: some View {
        CertificatesView()
    }
}
