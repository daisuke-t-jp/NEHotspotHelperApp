//
//  ViewController.swift
//  NEHotspotHelperApp
//
//  Created by Daisuke T on 2019/01/08.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  // MARK: outlet
  @IBOutlet weak var _textfieldBSSID: UITextField!
  @IBOutlet weak var _textfieldSSID: UITextField!
  @IBOutlet weak var _textfieldPW: UITextField!
  @IBOutlet weak var _button: UIButton!

  
  // MARK: life-cycle
  override func viewDidLoad() {
	  super.viewDidLoad()
	  
	  _textfieldBSSID.delegate = self
	  _textfieldSSID.delegate = self
	  _textfieldPW.delegate = self
	  
	  _button.addTarget(self,
	  	  	    action: #selector(ButtonAction),
	  	  	    for: UIControl.Event.touchUpInside)
  }
  
  
  // MARK: UITextField delegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
	  view.endEditing(true)
	  return false
  }
  
  
  // MARK: Button Action
  @objc fileprivate func ButtonAction(_ sender: AnyObject)
  {
	  var alertMessage: String = ""
	  if _textfieldSSID!.text!.count == 0
	  {
  	  alertMessage = "SSID is empty."
	  }
	  else if _textfieldPW!.text!.count == 0
	  {
  	  alertMessage = "PW is empty."
	  }

	  guard alertMessage.count == 0 else {
  	  let alert: UIAlertController = UIAlertController(title: "",
  	  	  	  	  	  	  	   message: alertMessage,
  	  	  	  	  	  	  	   preferredStyle: UIAlertController.Style.alert)
  	  
  	  let actionOK: UIAlertAction = UIAlertAction(title: "OK",  style: UIAlertAction.Style.default, handler:nil)
  	  alert.addAction(actionOK)
  	  present(alert, animated: true, completion: nil)
  	  
  	  return
	  }
	  
	  let hotspot: Hotspot = Hotspot()
	  hotspot.bssid = _textfieldBSSID!.text!
	  hotspot.ssid = _textfieldSSID!.text!
	  hotspot.pw = _textfieldPW!.text!

	  HotspotHelperManager.sharedInstance.hotspots = [hotspot]

	  
	  let alert: UIAlertController = UIAlertController(title: "",
	  	  	  	  	  	  	   message: "Register.",
	  	  	  	  	  	  	   preferredStyle: UIAlertController.Style.alert)
	  
	  let actionOK: UIAlertAction = UIAlertAction(title: "OK",  style: UIAlertAction.Style.default, handler:nil)
	  alert.addAction(actionOK)
	  present(alert, animated: true, completion: nil)
  }
}

