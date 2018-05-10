//
//  MAGChooseSectionViewController.swift
//  MagisterGL
//
//  Created by Admin on 03.05.2018.
//  Copyright © 2018 Хохлова Татьяна. All rights reserved.
//

import UIKit

protocol MAGChooseSectionViewControllerDelegate
{
  func drawSection(sectionType: PlaneType,
                   sectionValue: Float)
  func deleteSection()
}

class MAGChooseSectionViewController: UIViewController, UIPopoverPresentationControllerDelegate
{
  var delegate: MAGChooseSectionViewControllerDelegate?
  
  @IBOutlet weak var sectionXTextField: UITextField!
  
  
  @IBAction func drawSectionButtonTapped()
  {
    delegate?.drawSection(sectionType: .X,
                          sectionValue: (self.sectionXTextField.text! as NSString).floatValue)
    self.dismiss(animated: true,
                 completion: nil)
  }
  
  @IBAction func deleteSection()
  {
    delegate?.deleteSection()
    self.dismiss(animated: true,
                 completion: nil)
  }
  
}
