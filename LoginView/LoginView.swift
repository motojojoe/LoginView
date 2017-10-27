//
//  LoginView.swift
//  LoginButton
//
//  Created by Atthachai Meethong on 10/27/17.
//  Copyright © 2017 Atthachai Meethong. All rights reserved.
//

import UIKit

@IBDesignable

class LoginView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var contentView: UIView!
    var tempwidth: CGFloat!
    
    public override init(frame: CGRect) {
        // For use in code
        super.init(frame: frame)
        setUpView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        setUpView()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        roundCorner()
        tempwidth = frame.width
    }
    
    private func setUpView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true

        addSubview(contentView)
        
        let selector = #selector(LoginView.tap(_:))
        let tap = UITapGestureRecognizer(target: self, action: selector)
        addGestureRecognizer(tap)
        
        indicator.stopAnimating()
    }

    private func roundCorner() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
    
    private func animateView() {
        if frame.width == tempwidth {
            let center = self.center
            let newSize = CGSize(width: frame.height, height: frame.height)
            titleLabel.isHidden = true            
            UIView.animate(withDuration: 0.2, animations: {
                self.frame.size = newSize
                self.center = center
            }, completion: { (_) in
                self.indicator.startAnimating()
            })

        } else {
            let center = self.center
            let newSize = CGSize(width: tempwidth, height: frame.height)
            self.indicator.stopAnimating()
            UIView.animate(withDuration: 0.2, animations: {
                self.frame.size = newSize
                self.center = center
            }, completion: { (_) in
                self.titleLabel.isHidden = false
            })
        }

    }
    
    @objc private func tap(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended: animateView()
        default: break
        }
    }
}
