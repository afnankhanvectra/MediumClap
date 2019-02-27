//
//  ViewController.swift
//  MediumClap
//
//  Created by Afnan Khan on 2/10/19.
//  Copyright © 2019 Afnan Khan. All rights reserved.
//

import UIKit
import SpriteKit


class ViewController: UIViewController {
    let VIEW_TAG = 100
    var disAppearWork :DispatchWorkItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func clapButtonClicked(_ sender: UIButton) {
        if self.view.viewWithTag(VIEW_TAG) as? UILabel == nil {
            
            createLabelInCircle(atPosition: sender.frame.origin)
        }
        increaseLabelCount()
        crateParticle(onView: sender)
        
    }
    
    func createLabelInCircle(atPosition position : CGPoint){
        let size:CGFloat = 35.0
        
        let countLabel = UILabel(frame: CGRect(x : position.x,y :position.y,width : size, height :  size))
        countLabel.text = "0"
        countLabel.textColor = UIColor.white
        countLabel.textAlignment = .center
        
        countLabel.font = UIFont.systemFont(ofSize: 14.0)
        countLabel.layer.cornerRadius = size / 2
        countLabel.layer.borderWidth = 0.5
        countLabel.layer.masksToBounds = true
        countLabel.layer.backgroundColor = UIColor.blue.cgColor
        countLabel.layer.borderColor = UIColor.white.cgColor
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(countLabel)
        countLabel.tag = VIEW_TAG
        UIView.animate(withDuration: 0.5, animations: {
            countLabel.frame.origin.y -= 100
            
        }) {  (complete) in
            if complete == true {
            }
            
        }
        
        
    }
    
    func increaseLabelCount(){
        
        guard let countLabel = self.view.viewWithTag(VIEW_TAG) as? UILabel else  { return}
        let  labelCount = (Int)(countLabel.text ?? "0")
        countLabel.text = "+\(labelCount!  + 1)"
        if labelCount! > 0 {
            countLabel.zoomInWithEasing(withDuration: 0.11, easingOffset: 0.3)
        }
        callDisappearView()
        
    }
    
    
    func callDisappearView(){
        
        disAppearWork?.cancel()
        
        disAppearWork = DispatchWorkItem(block: {   [weak self ] in
            self?.disappearViewAfterTime()
            
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: disAppearWork!)
        
        
    }
    func disappearViewAfterTime(){
        guard let countLabel = self.view.viewWithTag(VIEW_TAG) as? UILabel else  { return}
        UIView.animate(withDuration: 0.5, animations: {
            countLabel.alpha = 0.0
            countLabel.frame.origin.y -= 100
        }) {  (complete) in
            countLabel.removeFromSuperview()
        }
        
    }
    
    
    func crateParticle(onView particleView : UIView){
        
        print("Called")
        
        let sk: SKView = SKView()
        sk.frame = particleView.bounds
        sk.backgroundColor = .clear
        particleView.addSubview(sk)
        
       
        let scene: SKScene = SKScene(size: CGSize(width: particleView.bounds.size.width , height: particleView.bounds.size.height ) )
        scene.scaleMode = .aspectFit
        scene.backgroundColor = .clear
        
        let en = SKEmitterNode(fileNamed: "MyParticle222.sks")
         en?.position = sk.center
        
        
 
        scene.addChild(en!)
        sk.presentScene(scene)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sk.removeFromSuperview()

        }
        
        
    }
}

