//
//  File.swift
//  MockNFCTag
//
//  Created by Jose Aponte on 26/05/23.
//

import Foundation
import CoreNFC


protocol CommandExecutor {
  
  func write(data dataToWrite: Data, for tag: NFCMiFareTag) async -> Data
}

final class AirTag: CommandExecutor {
  
  func write(data dataToWrite: Data, for tag: NFCMiFareTag) async -> Data {
    let result = await withCheckedContinuation{ (continuation: CheckedContinuation<Data, Never>) in
      tag.sendMiFareCommand(commandPacket: dataToWrite) { result in
        // logic what I need to test
        switch result {
        case .success(let res):
          continuation.resume(returning: res)
        case .failure(let error):
          print("error \(error)")
        }
      }
    }
    return result
  }
}
