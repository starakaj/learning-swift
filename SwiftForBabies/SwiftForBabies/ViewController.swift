//
//  ViewController.swift
//  SwiftForBabies
//
//  Created by Sam Tarakajian on 2/24/16.
//  Copyright © 2016 girlfriends. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet var hiButton: UIButton!
    var audioPlayer = AVAudioPlayer()
    var catSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cat", ofType: "wav")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do { audioPlayer = try AVAudioPlayer(contentsOfURL: catSound, fileTypeHint: nil) }
        catch let error as NSError { print(error.description) }
        audioPlayer.prepareToPlay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sayHi(sender: UIButton) {
        audioPlayer.play()
        performCatAnimation()
    }
    
    func performCatAnimation() {
        var catImage: UIImage
        var catView: UIImageView
        
        catImage = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("cat1", ofType: "png")!)!
        catView = UIImageView(image: catImage)
        catView.hidden = true
        self.view.addSubview(catView)
        let offscreenPoint = CGPoint(x: -catView.frame.size.width/2, y: catView.frame.size.height/2 + self.view.frame.size.height)
        catView.center = offscreenPoint
        catView.hidden = false
        
        // Animate the cat onscreen
        let inAnimation = POPBasicAnimation(propertyNamed: kPOPViewCenter)
        inAnimation.toValue = NSValue(CGPoint:self.view.center)
        inAnimation.duration = 0.3
        
        // Animate the cat offscreen
        let outAnimation = POPBasicAnimation(propertyNamed: kPOPViewCenter)
        outAnimation.toValue = NSValue(CGPoint:offscreenPoint)
        outAnimation.duration = 1.0
        outAnimation.beginTime = CACurrentMediaTime() + inAnimation.duration
        outAnimation.completionBlock = { (popAnimation:POPAnimation!, complete:Bool) -> Void in
            catView.removeFromSuperview()
        }
        
        catView.pop_addAnimation(inAnimation, forKey: "enter_the_cat")
        catView.pop_addAnimation(outAnimation, forKey: "exit_the_cat")
    }

}

