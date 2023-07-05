//
//  TracableScrollview.swift
//  SwiftUICombinWithData
//
//  Created by HardiB.Salih on 6/29/23.
//

import SwiftUI

/// A custom ScrollView that tracks the content offset changes.
///
/// This ScrollView provides a way to track changes in the content offset. It emits the updated offset as a CGPoint using the `offsetChanged` closure.
///
/// Example usage:
///
///     TraceableScrollView {
///         // Content views here
///     } offsetChanged: { offset in
///         // Handle the offset change
///     }
///
struct TraceableScrollView<Content: View>: View {
    let axis: Axis.Set
    let offsetChanged: (CGPoint) -> Void
    let content: Content
    
    /// Creates a TraceableScrollView with the specified axis, offsetChanged closure, and content.
    ///
    /// - Parameters:
    ///   - axis: The scroll view's scrollable axis. The default value is `.vertical`.
    ///   - offsetChanged: A closure that gets called when the content offset changes. The default value is an empty closure.
    ///   - content: A closure that provides the content of the scroll view.
    init(axis: Axis.Set = .vertical, offsetChanged: @escaping (CGPoint) -> Void = { _ in }, @ViewBuilder content: () -> Content) {
        self.axis = axis
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    var body: some View {
        ScrollView(axis) {
            GeometryReader { geometry in
                Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scrollView")).origin)
            }
            .frame(width: 0, height: 0)
            
            content
        }
        .coordinateSpace(name: "scrollView")
        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
    }
}

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}

