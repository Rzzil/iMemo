//
//  RecordManager.swift
//  iMemo
//
//  Created by Zihao Yan,Kang Xie,Tianqi Fu on 2020/6/10.
//  Copyright © 2020 Enterprise. All rights reserved.
//

import Foundation
import AVFoundation

class RecordManager {
    var recorder: AVAudioRecorder?
    var player: AVAudioPlayer?
    var sequence: Int = 0
    var file_path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/record"+"0"+".wav")
    
    var play_path: String?
    
    
    //开始录音
    func beginRecord() {
        //get number of records
        let userDefaults = UserDefaults.standard
        sequence = userDefaults.integer(forKey: "sequence")
        file_path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/record"+String(sequence)+".wav")
        let session = AVAudioSession.sharedInstance()
        //设置session类型
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord)
        } catch let err{
            print("Fail to set type:\(err.localizedDescription)")
        }
        //设置session动作
        do {
            try session.setActive(true)
        } catch let err {
            print("Fail to init:\(err.localizedDescription)")
        }
        //Record setting
        let recordSetting: [String: Any] = [AVSampleRateKey: NSNumber(value: 16000),//采样率
                                            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),//音频格式
                                            AVLinearPCMBitDepthKey: NSNumber(value: 16),//采样位数
                                            AVNumberOfChannelsKey: NSNumber(value: 1),//通道数
                                            AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)//录音质量
        ];
        //Start recording
        do {
            let url = URL(fileURLWithPath: file_path!)
            recorder = try AVAudioRecorder(url: url, settings: recordSetting)
            recorder!.prepareToRecord()
            recorder!.record()
            //update record number
            sequence += 1
            print("Start recording")
        } catch let err {
            print("Fail to record:\(err.localizedDescription)")
        }
    }
    
    
    //Stop recording
    func stopRecord() {
        if let recorder = self.recorder {
            if recorder.isRecording {
                print("Recording，File save to：\(file_path!)")
            }else {
                print("Not recording，end it anyway")
            }
            recorder.stop()
            self.recorder = nil
        }else {
            print("Fail to init")
        }
    }
    
    
    //播放
    func play() {
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: play_path!))
            print("Audio length：\(player!.duration)")
            player!.play()
        } catch let err {
            print("Fail to play:\(err.localizedDescription)")
        }
    }
    
    
    
}
