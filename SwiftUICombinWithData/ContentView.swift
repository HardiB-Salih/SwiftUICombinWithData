//
//  ContentView.swift
//  SwiftUICombinWithData
//
//  Created by HardiB.Salih on 6/29/23.
//

import SwiftUI

struct ContentView: View {
    @State private var contentOffset = CGFloat(0)
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var showCertificates: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .top){
                TraceableScrollView(offsetChanged: { offset in
                    withAnimation(.easeIn) {
                        contentOffset = offset.y
                    }
                    
                }) {
                    content
                }
                
                
                VisualEffectBlur(blurStyle: .systemMaterial)
                    .opacity(contentOffset < -16  ? 1 : 0)
                    .ignoresSafeArea()
                    .frame(height: 0)
                
            }.frame(maxHeight: .infinity, alignment: .top)
                .background(AccountBackground())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(colorScheme == .dark ? .white : Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
    }
    
    var content: some View {
        VStack {
            ProfileRow().onTapGesture {
                showCertificates.toggle()
            }
            
            VStack{
                NotificationsRow()
                divider
                LiteModeRow()
            }.blurBackground()
                .padding(.top, 10)
            
            
            
            
            VStack{
                NavigationLink(destination: FAQView()) {
                    MenuRow()
                }
                divider
                NavigationLink(destination: PackagesView()) {
                    MenuRow(title: "SwiftUI Packages", leftIcon: "square.stack.3d.up.fill")
                }
                divider
                CustomLink(urlString: "https://hardibsalih.app/") {
                    MenuRow(title: "YouTube Channel", leftIcon: "play.rectangle.fill", rightIcon: "link")

                }
                
                

            }.blurBackground()
                .padding(.top, 10)
            
            Text("Vesion: 1.00")
                .foregroundColor(.white.opacity(0.7))
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                .font(.footnote)
        }.foregroundColor(.white)
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
            .sheet(isPresented: $showCertificates) {
                CertificatesView()
            }
    }
    
    var divider: some View {
        Divider().background(Color.white.blendMode(.overlay))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
