//
//  RecordSoundViewController.swift
//  Pitch Perfect
//
//  Created by Arafat on 3/16/15.
//  Copyright (c) 2015 Arafat. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundViewController: UIViewController,AVAudioRecorderDelegate {
    
    // MARK: View IBOutlet
    
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var lblRecordingInProgress: UILabel!
    @IBOutlet weak var lblTapRecord: UILabel!
    @IBOutlet weak var btnRecord: UIButton!
    
    
    // MARK: Global Variables
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    // MARK: Controller Initaial Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        btnRecord.enabled = true;
        btnStop.hidden = true;
        lblRecordingInProgress.hidden = true;
        lblTapRecord.hidden = false;
    }
    
    
    // MARK: Action methods
    
    @IBAction func recordVoice(sender: UIButton) {
        println("recording in progress")
        
        btnRecord.enabled = false;
        lblTapRecord.hidden = true;
        lblRecordingInProgress.hidden = false
        btnStop.hidden = false;
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        //Set Delegate
        audioRecorder.delegate = self;
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        
        println("Stop Recording")
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    // MARK: AVAudioRecorderDelegate Delegate methods
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag){
            
            recordedAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePathUrl: recorder.url)
            
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else{
            
            println("Recording was not successful")
            btnRecord.enabled = true;
            btnStop.hidden = true;
            lblRecordingInProgress.hidden = true;
            lblTapRecord.hidden = false;
        }
        
        
    }
    
    // MARK: UIStoryboardSegue methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "stopRecording"){
            
            let playSoundVC: PlaySoundViewController = segue.destinationViewController as PlaySoundViewController
            
            let data = sender as RecordedAudio
            playSoundVC.receivedAudio = data
        }
    }
    
    // MARK: Controller Unload Methods
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

