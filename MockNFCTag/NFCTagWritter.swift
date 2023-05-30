//
//  NFCTagWritter.swift
//  MockNFCTag
//
//  Created by Jose Aponte on 26/05/23.
//

import Foundation
import CoreNFC

final class TagReader: NSObject, NFCTagReaderSessionDelegate {
  
  let airTag: CommandExecutor!
  var session: NFCTagReaderSession!
  
  init(airTag: CommandExecutor!) {
    self.airTag = airTag
  }
  
  func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {}
  func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {}
  
  func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
    guard let firstTag = tags.first else { return }
    
    switch firstTag {
    case .miFare(let tag):
      // tag is NFCMiFare
      Task {
        /// Now as I have the concrete implementation of `MyNFCMiFareTag` for CoreNFC I can pass it to the ariTag.writer
        let myTag = CoreNCFMyNFCMiFareTag(tag: tag)
        let result = await airTag.write(data: Data(), for: myTag)
      }
    default:
      break
    }
  }
}

class CoreNCFMyNFCMiFareTag: MyNFCMiFareTag {
  
  let tag: NFCMiFareTag
  
  init(tag: NFCMiFareTag) {
    self.tag = tag
  }
  
  func sendMiFareCommand(commandPacket command: Data, resultHandler: @escaping (Result<Data, Error>) -> Void) {
    tag.sendMiFareCommand(commandPacket: command, resultHandler: resultHandler)
  }
  
}

let airTag = AirTag()
let tag1 = TagReader(airTag: airTag)







