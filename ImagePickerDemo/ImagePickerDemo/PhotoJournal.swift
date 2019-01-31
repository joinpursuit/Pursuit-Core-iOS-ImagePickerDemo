//
//  PhotoJournal.swift
//  ImagePickerDemo
//
//  Created by Alex Paul on 1/14/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import Foundation

struct PhotoJournal: Codable {
  let createdAt: String
  let imageData: Data
  let description: String
}
