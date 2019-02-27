//
//  ParticleTestController.swift
//  MediumClap
//
//  Created by Afnan Khan on 2/21/19.
//  Copyright © 2019 Afnan Khan. All rights reserved.
//

import UIKit
import SpriteKit


class ParticleTestController: UIViewController {

    @IBOutlet weak var teste: UIView! // totally ordinary UIView

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
 
       let  timer2 = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(crateParticle), userInfo: nil, repeats: true)

        
        timer2.fire()
     //   crateParticle()
    }

    @objc func crateParticle(){
        
        print("Called")
        
        let sk: SKView = SKView()
        sk.frame = teste.bounds
        sk.backgroundColor = .clear
        teste.addSubview(sk)
        
        let scene: SKScene = SKScene(size: teste.bounds.size)
        scene.scaleMode = .aspectFit
        scene.backgroundColor = .clear
        
        let en = SKEmitterNode(fileNamed: "MyParticle222.sks")
        en?.particleColor = .green
         en?.position = sk.center
        
        
        en?.particleColor = SKColor.green

         scene.addChild(en!)
        sk.presentScene(scene)
        
    }

}
