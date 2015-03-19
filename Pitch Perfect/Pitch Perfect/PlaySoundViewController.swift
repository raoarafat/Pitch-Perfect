//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Arafat on 3/17/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    // MARK: Global Variables
    
    var avAudioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    // MARK: Controller Initaial Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        avAudioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        avAudioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)

        
        
        
    }
    
     override func viewDidDisappear(animated: Bool) {
        
        self.stoppingAudio()
    }

    
    
    // MARK: Action methods
    
    func stoppingAudio(){
        
        avAudioPlayer.stop()
        audioEngine.stop()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        
        self.stoppingAudio()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
        
    }
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
      
        self.stoppingAudio()
       
        avAudioPlayer.currentTime = 0.0
        avAudioPlayer.rate = 1.5
        avAudioPlayer.play()
    
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        
        self.stoppingAudio()

        
        avAudioPlayer.currentTime = 0.0
        avAudioPlayer.rate = 0.5
        avAudioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
      
        self.stoppingAudio()
       
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    // MARK: Controller Unload Methods
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
