//
//  ViewController.swift
//  Faceit
//
//  Created by 王跃 on 17/4/19.
//  Copyright © 2017年 cmcc. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView!{
        didSet{
            let  handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer =  UIPinchGestureRecognizer(target:faceView, action:handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            let tapRecognizer = UITapGestureRecognizer(target:self, action:#selector(self.toggleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 1
            faceView.addGestureRecognizer(tapRecognizer)
            let swipeUpRecognizer = UISwipeGestureRecognizer(target:self, action:#selector(increaseHappiness))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            let swipeDownRecognizer = UISwipeGestureRecognizer(target:self, action:#selector(decreaseHappiness))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
           updateUI()
        }
    }
  
    func increaseHappiness()
    {
        expression = expression.happier
    }
    
    func decreaseHappiness()
    {
       expression = expression.sadder
    }
    
    
    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer){
        if tapRecognizer.state == .ended{
            let eyes:FacialExpression.Eyes = (expression.eyes == .Closed) ? .Open : .Closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
    }
    
    var expression = FacialExpression(eyes:.Open, mouth:.Neutral){
        didSet{
           updateUI()
        }
    }

    private func updateUI(){
        switch expression.eyes{
        case .Open:
            faceView?.eyesOpen = true//? 有可能faveView有可能还没有呗hoookedup，有可能是nil， ？ 加上后如果是nil则这行代码不执行。 在updateUI的地方都要这样写。
        case .Closed:
            faceView?.eyesOpen = false
        case .Squinting:
            faceView?.eyesOpen = false
        }
        
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.Grin:0.5, .Frown:-1.0, .Smile:1.0, .Neutral:0.0, .Smirk:-0.5]
}

