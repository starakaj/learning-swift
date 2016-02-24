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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sayHi(sender: UIButton) {
        audioPlayer.play()
    }

}

