//
//  SpeechConvertViewController.swift
//  iMemo
//
//  Created by admin on 10/6/20.
//  Copyright © 2020 Enterprise. All rights reserved.
//

import UIKit
import Speech
import AVKit
import Foundation


class SpeechConvertViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,SFSpeechRecognizerDelegate {
    
    let manager = FileManager.default
    let url = NSHomeDirectory() + "/Documents/"
    
    var cintents1 = [String]()
    var currentCell: UITableViewCell?
    
    
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
        print("测试:" + (currentCell?.textLabel?.text ?? ""))
    }
    
        

    @IBOutlet weak var convertedText: UITextField!
    

    @IBAction func convertVoice(_ sender: Any) {
        let front: String = "file://"
        let fileUrl = URL(string: (front + url  + (currentCell!.textLabel!.text!)))
        transcribeAudio(url: fileUrl!)
    }
    
    func requestTranscribePermissions() {
        SFSpeechRecognizer.requestAuthorization { [unowned self] authStatus in
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
        //let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
        //        let domain = Bundle.main.bundleIdentifier!
        //        UserDefaults.standard.removePersistentDomain(forName: domain)
                print("地址："+url)
                do
                {
                    cintents1 = try manager.contentsOfDirectory(atPath: url)
                    print("cintents:\(cintents1)\n")
                } catch{
                    print("Error occurs.")
                }
        
        
                
                // Do any additional setup after loading the view.

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
