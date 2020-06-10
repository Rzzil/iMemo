//
//  RecordViewController.swift
//  iMemo
//
//  Created by Rzzil on 2020/6/10.
//  Copyright © 2020 Enterprise. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    let manager = FileManager.default
    let url = NSHomeDirectory() + "/Documents/"
    
    var cintents1 = [String]()
    var currentCell: UITableViewCell?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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

    let recorder = RecordManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    
    @IBAction func StartRecording(_ sender: Any) {
        recorder.beginRecord()
    }
    
    @IBAction func StopRecording(_ sender: Any) {
        recorder.stopRecord()
        
        let manager = FileManager.default
        let url = NSHomeDirectory() + "/Documents/"
        do
        {
            cintents1 = try manager.contentsOfDirectory(atPath: url)
            print("cintents:\(cintents1)\n")
        } catch{
            print("Error occurs.")
        }
        
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func Play(_ sender: Any) {
        recorder.play_path = url + (currentCell?.textLabel?.text ?? "")
        recorder.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(recorder.sequence, forKey: "sequence")
    }
}
