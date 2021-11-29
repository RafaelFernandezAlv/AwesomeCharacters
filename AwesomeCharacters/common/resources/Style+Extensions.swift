//
//  Style+Extensions.swift
//  AwesomeCharacters
//
//  Created by rafael.fernandez on 29/11/21.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIView {
    func styleSeparator() {
        self.backgroundColor = .gray
    }
    
    func styleBackground() {
        self.backgroundColor = .white
    }
    
    func styleTransparent() {
        self.backgroundColor = .black
        self.alpha = 0.7
    }
}

extension UINavigationController {
    func styleDefault() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Asset.red.color
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                          NSAttributedString.Key.font: FontFamily.OpenSans.bold.font(size: 22)]
        self.navigationBar.standardAppearance = appearance;
        self.navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        self.navigationBar.tintColor = .white
    }
}

extension UISearchBar {
    func styleDefault() {
        self.tintColor = Asset.red.color
        self.backgroundColor = Asset.red.color
    }
}

extension NVActivityIndicatorView {
    func styleDefault() {
        self.type = .pacman
        self.color = Asset.red.color
    }
}

extension UILabel {
    
    func styleWhite() {
        self.textColor = .white
    }
    
    func styleBlack() {
        self.textColor = .black
    }
    
    func styleRegularH1() {
        self.font = FontFamily.OpenSans.regular.font(size: 25)
    }
    
    func styleRegularH2() {
        self.font = FontFamily.OpenSans.regular.font(size: 22)
    }
    
    func styleRegularBody() {
        self.font = FontFamily.OpenSans.regular.font(size: 16)
    }
    
    func styleBoldH1() {
        self.font = FontFamily.OpenSans.bold.font(size: 25)
    }
    
    func styleBoldH2() {
        self.font = FontFamily.OpenSans.bold.font(size: 22)
    }
    
    func styleBoldBody() {
        self.font = FontFamily.OpenSans.bold.font(size: 16)
    }
    
    func styleItalicBody() {
        self.font = FontFamily.OpenSans.italic.font(size: 16)
    }
    
    func styleItalicCaption() {
        self.font = FontFamily.OpenSans.italic.font(size: 13)
    }
}

extension UIButton {
    func styleDefault() {
        self.setTitleColor(.white, for: .normal)
        self.tintColor = Asset.red.color
        self.backgroundColor = Asset.red.color
    }
}
