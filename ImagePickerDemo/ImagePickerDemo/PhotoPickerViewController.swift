//
//  ViewController.swift
//  ImagePickerDemo
//
//  Created by Alex Paul on 1/14/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit
import AVFoundation

class PhotoPickerViewController: UIViewController {
  
  @IBOutlet weak var cameraButton: UIBarButtonItem!
  @IBOutlet weak var imageView: UIImageView!
  
  private var imagePickerViewController: UIImagePickerController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupImagePickerViewController()
    
    // retrieve and set image view if photo journal exist
    updateUI()
  }
  
  private func updateUI() {
    if let photoJournal = PhotoJournalModel.getPhotoJournal() {
      let image = UIImage(data: photoJournal.imageData)
      imageView.image = image
    } else {
      print("photo journal does not exist")
    }
  }
  
  private func setupImagePickerViewController() {
    imagePickerViewController = UIImagePickerController()
    imagePickerViewController.delegate = self
    if !UIImagePickerController.isSourceTypeAvailable(.camera) {
      cameraButton.isEnabled = false
    }
  }
  
  private func showImagePickerController() {
    present(imagePickerViewController, animated: true, completion: nil)
  }
  
  @IBAction func photoLibraryButtonPressed(_ sender: UIBarButtonItem) {
    imagePickerViewController.sourceType = .photoLibrary
    showImagePickerController()
  }
  
  @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
    imagePickerViewController.sourceType = .camera
    showImagePickerController()
  }
  
  private func savePhotoJournal(image: UIImage) {
    // PhotoJournal: createdAt, description, imageData
    if let imageData = image.jpegData(compressionQuality: 0.5) {
      let photoJournal = PhotoJournal.init(createdAt: "no date", imageData: imageData, description: "cool wallpaper")
      PhotoJournalModel.savePhotoJournal(photoJournal: photoJournal)
    }
  }
}

extension PhotoPickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      imageView.image = image
      savePhotoJournal(image: image)
    } else {
      print("original image is nil")
    }
    dismiss(animated: true, completion: nil)
  }
}

