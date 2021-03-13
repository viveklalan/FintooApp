//
//  UIViewExtension.swift
//  FintooApp
//
//  Created by Jai Mataji on 09/03/21.
//

import UIKit

extension UIView {
    func addRadius(brRadius: CGFloat = 5.0) -> Void {
        layer.cornerRadius = brRadius
        layer.masksToBounds = true
    }
    
    func addBorder(brWidth: CGFloat = 0.5, brColor: UIColor = .black) -> Void {
        layer.borderWidth = brWidth
        layer.borderColor = brColor.cgColor
    }
    
    func addBorderWithRadius(brWidth: CGFloat = 0.5, brColor: UIColor = .black, brRadius:CGFloat = 5) -> Void {
        layer.cornerRadius = brRadius
        layer.borderWidth = brWidth
        layer.borderColor = brColor.cgColor
    }
    
    func dropShadow() {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOpacity = 0.5
      layer.shadowOffset = CGSize(width: -1, height: 1)
      layer.shadowRadius = 1
    }
}
