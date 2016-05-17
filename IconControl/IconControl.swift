//
//  IconControl.swift
//  IconControl
//
//  Created by Marquis Dennis on 5/16/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit

@IBDesignable
class IconControl: UIControl {
    
    private lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFontOfSize(30.0, weight: UIFontWeightLight)
        return label
    }()
    
    private var spacingConstraint: NSLayoutConstraint!
    
    @IBInspectable
    var spacing:CGFloat = 20.0 {
        didSet {
            spacingConstraint?.constant = spacing
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInitializer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInitializer()
    }
    
}

extension IconControl {
    @IBInspectable
    var image: UIImage? {
        get {
            return imageView.image
        }
        set (newImage) {
            imageView.image = newImage?.imageWithRenderingMode(.AlwaysTemplate)
        }
    }
    
    @IBInspectable
    var text: String? {
        get {
            return label.text
        }
        set (newText) {
            label.text = newText
        }
    }
}

extension IconControl {
    private func sharedInitializer() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addSubview(imageView)
        
        label.textColor = tintColor
        spacingConstraint =  label.leftAnchor.constraintEqualToAnchor(imageView.rightAnchor, constant: spacing)
        
        NSLayoutConstraint.activateConstraints([
            imageView.leadingAnchor.constraintEqualToAnchor(layoutMarginsGuide.leadingAnchor),
            imageView.topAnchor.constraintEqualToAnchor(layoutMarginsGuide.topAnchor),
            imageView.bottomAnchor.constraintEqualToAnchor(layoutMarginsGuide.bottomAnchor),
            spacingConstraint,
            label.rightAnchor.constraintEqualToAnchor(layoutMarginsGuide.rightAnchor),
            imageView.centerYAnchor.constraintEqualToAnchor(label.centerYAnchor)
            ])
        
        label.setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: .Horizontal)
        imageView.setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: .Horizontal)
        setContentHuggingPriority(UILayoutPriorityDefaultHigh, forAxis: .Horizontal)
        
        layer.cornerRadius = 10
        
        addTapGestureRecognizer()
    }
}

extension IconControl {
    override func tintColorDidChange() {
        super.tintColorDidChange()
        label.textColor = tintColor
    }
}

extension IconControl {
    private func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleIconTapped:")
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    func handleIconTapped(sender: UITapGestureRecognizer) {
        sendActionsForControlEvents(.TouchUpInside)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        animateTintAdjustmentMode(.Dimmed)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        animateTintAdjustmentMode(.Normal)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        animateTintAdjustmentMode(.Normal)
    }
    
    private func animateTintAdjustmentMode(mode: UIViewTintAdjustmentMode) {
        UIView.animateWithDuration(mode == .Normal ? 0.3 : 0.05) { () -> Void in
            self.tintAdjustmentMode = mode
        }
    }
}