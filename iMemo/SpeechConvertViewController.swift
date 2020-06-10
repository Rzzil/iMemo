//
//  RecordManager.swift
//  iMemo
//
//  Created by Zihao Yan,Kang Xie,Tianqi Fu on 2020/6/10.
//  Copyright © 2020 Enterprise. All rights reserved.
//

import UIKit
import Speech
import AVKit
import Foundation


class SpeechConvertViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,SFSpeechRecognizerDelegate {
    
    //declare url and file manager
    let manager = FileManager.default
    let url = NSHomeDirectory() + "/Documents/"
    
    var cintents1 = [String]()
    var currentCell: UITableViewCell?
    
    //tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cintents1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        if(indexPath.row != 0)
        {
            cell.textLabel?.text = cintents1[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCell = tableView.cellForRow(at: indexPath)
        print("test:" + (currentCell?.textLabel?.text ?? ""))
    }
    
        
    //voice convert funcs
    @IBOutlet weak var convertedText: UITextField!
    
    
    @IBAction func convertVoice(_ sender: Any) {
        let front: String = "file://"
        let fileUrl = URL(string: (front + url  + (currentCell!.textLabel!.text!)))
        transcribeAudio(url: fileUrl!)
    }
    
    func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                if authStatus == .authorized {
                    print("Good to go!")
                } else {
                    print("Transcription permission was declined.")
                }
            }
        }
    }
    
    func transcribeAudio(url: URL) {
        // create a new recognizer and point it at our audio
        let recognizer = SFSpeechRecognizer()
        let request = SFSpeechURLRecognitionRequest(url: url)
    
        // start recognition!
        recognizer?.recognitionTask(with: request) { [unowned self] (result, error) in
            // abort if we didn't get any transcription back
            guard let result = result else {
                print("There was an error: \(error!)")
                return
            }
    
            // if we got the final transcription back, print it
            if result.isFinal {
                // pull out the best transcription...
                let finalResult = result.bestTranscription.formattedString
                self.convertedText.text = String(finalResult)
                print(finalResult)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("address："+url)
        do
        {
            cintents1 = try manager.contentsOfDirectory(atPath: url)
            print("cintents:\(cintents1)\n")
        } catch{
            print("Error occurs.")
        }
    }
}
