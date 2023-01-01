//
//  TextEditor.swift
//  Tasks
//
//  Created by Ivan Konishchev on 30.12.2022.
//

import SwiftUI

@available(iOS 13.0, *)
public struct TextEditor: View {
    @State var dynamicHeight: CGFloat = 100
    private let richText: NSMutableAttributedString
    private let placeholder: String
    private let accessorySections: Array<EditorSection>
    private let onCommit: (NSAttributedString) -> Void
    public init(
        richText: NSMutableAttributedString,
        placeholder: String = "",
        accessory sections: Array<EditorSection> = EditorSection.allCases,
        onCommit: @escaping ((NSAttributedString) -> Void)
    ) {
        self.richText = richText
        self.placeholder = placeholder
        self.accessorySections = sections
        self.onCommit = onCommit
    }
    
    public var body: some View {
        TextEditorWrapper(richText: richText, height: $dynamicHeight, placeholder: placeholder, sections: accessorySections, onCommit: onCommit)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
            
    }
}
