//
//  RecordViewController.swift
//  iMemo
//
//  Created by Rzzil on 2020/6/10.
//  Copyright © 2020 Enterprise. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    let recorder = RecordManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func StartRecording(_ sender: Any) {
        recorder.beginRecord()
    }
    
    @IBAction func StopRecording(_ sender: Any) {
        recorder.stopRecord()
    }
    
    @IBAction func Play(_ sender: Any) {
        recorder.play()
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
