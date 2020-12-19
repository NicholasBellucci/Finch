//
//  TextView.swift
//  Finch
//
//  Created by Nicholas Bellucci on 12/10/20.
//

import Combine
import SwiftUI

struct TextView: NSViewRepresentable {
    @Binding var text: String

    private var font: NSFont = .systemFont(ofSize: 14)
    private var isEditable: Bool = true

    private var onEditingChanged: (() -> ())?
    private var onEndEditing: (() -> ())?
    private var onTextChange: ((String) -> ())?

    init(text: Binding<String>) {
        _text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> TextViewRepresentable {
        let textView = TextViewRepresentable(
            text: text,
            font: font,
            isEditable: isEditable
        )

        textView.delegate = context.coordinator

        return textView
    }

    func updateNSView(_ view: TextViewRepresentable, context: Context) {
        view.text = text
        view.selectedRanges = context.coordinator.selectedRanges
    }
}

extension TextView {
    func font(_ font: NSFont) -> TextView {
        var copy = self
        copy.font = font
        return copy
    }

    func isEditable(_ value: Bool) -> TextView {
        var copy = self
        copy.isEditable = value
        return copy
    }

    func textDidBeginEditing(_ handler: @escaping (() -> ())) -> TextView {
        var copy = self
        copy.onEditingChanged = handler
        return copy
    }

    func textDidChange(_ handler: @escaping ((String) -> ())) -> TextView {
        var copy = self
        copy.onTextChange = handler
        return copy
    }

    func textDidEndEditing(_ handler: @escaping (() -> ())) -> TextView {
        var copy = self
        copy.onEndEditing = handler
        return copy
    }
}

extension TextView {
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: TextView
        var selectedRanges: [NSValue] = []

        init(_ parent: TextView) {
            self.parent = parent
        }

        func textDidBeginEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }

            self.parent.text = textView.string
            self.parent.onEditingChanged?()
        }

        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }

            self.parent.text = textView.string
            self.selectedRanges = textView.selectedRanges
        }

        func textDidEndEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else {
                return
            }

            self.parent.text = textView.string
            self.parent.onEndEditing?()
        }
    }
}

// MARK: - CustomTextView
final class TextViewRepresentable: NSView {
    weak var delegate: NSTextViewDelegate?

    private var font: NSFont
    private var isEditable: Bool

    var text: String {
        didSet {
            textView.string = text
        }
    }

    var selectedRanges: [NSValue] = [] {
        didSet {
            guard selectedRanges.count > 0 else {
                return
            }

            textView.selectedRanges = selectedRanges
        }
    }

    private lazy var scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.drawsBackground = false
        scrollView.borderType = .noBorder
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalRuler = false
        scrollView.autoresizingMask = [.width, .height]
        scrollView.automaticallyAdjustsContentInsets = false
        scrollView.contentInsets = NSEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        return scrollView
    }()

    private lazy var textView: PlainTextView = {
        let contentSize = scrollView.contentSize
        let textStorage = NSTextStorage()
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)

        let textContainer = NSTextContainer(containerSize: scrollView.frame.size)
        textContainer.widthTracksTextView = true
        textContainer.maximumNumberOfLines = 1
        textContainer.containerSize = NSSize(
            width: contentSize.width,
            height: CGFloat.greatestFiniteMagnitude
        )

        layoutManager.addTextContainer(textContainer)

        let textView = PlainTextView(frame: .zero, textContainer: textContainer)
        textView.autoresizingMask = .width
        textView.delegate = delegate
        textView.drawsBackground = false
        textView.font = font
        textView.isEditable = isEditable
        textView.isHorizontallyResizable = false
        textView.isVerticallyResizable = true
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.minSize = NSSize(width: 0, height: contentSize.height)
        return textView
    }()

    required init(
        text: String,
        font: NSFont = .systemFont(ofSize: 14),
        isEditable: Bool = true
    ) {
        self.text = text
        self.font = font
        self.isEditable = isEditable

        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDraw() {
        super.viewWillDraw()

        setupView()
    }
}

private extension TextViewRepresentable {
    func setupView() {
        scrollView.documentView = textView
        addSubview(scrollView)

        NSLayoutConstraint.activate(
            [
                scrollView.topAnchor.constraint(equalTo: topAnchor),
                scrollView.leftAnchor.constraint(equalTo: leftAnchor),
                scrollView.rightAnchor.constraint(equalTo: rightAnchor),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
}

private class PlainTextView: NSTextView {
    override func paste(_ sender: Any?) {
        pasteAsPlainText(sender)
    }
}
