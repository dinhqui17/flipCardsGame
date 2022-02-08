//
//  CustomView.swift
//  Conceptcube Test App
//
//  Created by Dinh Quy on 2/2/22.
//  Copyright © 2022 Dinh Quy. All rights reserved.
//

import UIKit

class CustomView: UIImageView {
    
    var lastLocation = CGPoint(x: 0, y: 0)
    
    var card : CardsModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(detectPan))
        self.gestureRecognizers = [panRecognizer]
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTapped)))
        self.image = K.Images.cardFaceUp
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func detectPan(_ recognizer:UIPanGestureRecognizer) {
        
        let translation  = recognizer.translation(in: self.superview)
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.superview?.bringSubviewToFront(self)
        lastLocation = self.center
        
    }
    
    
    @objc func imageTapped() {
        
        card.isUp = !card.isUp
        
        if card.isUp == true {
            image = UIImage(named: "cards/\(card.faceUp)")
        } else {
            return
            
        }
        
        
    }
    
    
}





