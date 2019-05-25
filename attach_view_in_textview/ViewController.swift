//
//  ViewController.swift
//  attach_view_in_textview
//
//  Created by AamirR on 5/25/19.
//  Copyright © 2019 AamirR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    private var xibAttachmentSubviewTag = 290
    
    @IBAction func attachNib() {
        if let xibView = UINib(nibName: "AttachmentView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.attach(view: xibView)
        }
    }
    
    @IBAction func attachNibAfterLayoutView() {
        if let xibView = UINib(nibName: "AttachmentView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            xibView.frame.size = CGSize(width: 398.0, height: 81.0)
            xibView.tag = self.xibAttachmentSubviewTag
            self.view.insertSubview(xibView, at: 0)
        }
    }
    
    @IBAction func attachView() {
        if let view = self.view.viewWithTag(1) {
            self.attach(view: view)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let view = self.view.viewWithTag(xibAttachmentSubviewTag) {
            self.attach(view: view)
            view.removeFromSuperview()
        }
        
    }
    
    private func attach(view: UIView) {
        // Create Attachment
        let image = view.toImage
        let attachment = NSTextAttachment()
        attachment.image = image
        //attachment.bounds = CGRect(origin: .zero, size: image.size)
        
        // Insert Attachment
        let currentAtStr = NSMutableAttributedString(attributedString: textView.attributedText)
        let attachmentAtStr = NSAttributedString(attachment: attachment)
        if let selectedRange = textView.selectedTextRange {
            let cursorIndex = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start)
            currentAtStr.insert(attachmentAtStr, at: cursorIndex)
            currentAtStr.addAttributes(self.textView.typingAttributes, range: NSRange(location: cursorIndex, length: 1))
        } else {
            currentAtStr.append(attachmentAtStr)
        }
        textView.attributedText = currentAtStr
    }
}
