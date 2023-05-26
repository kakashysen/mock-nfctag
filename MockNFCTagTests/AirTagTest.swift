//
//  AirTagTest.swift
//  MockNFCTagUITests
//
//  Created by Jose Aponte on 26/05/23.
//

import XCTest
@testable import MockNFCTag
import CoreNFC

final class AirTagTest: XCTestCase {
  
  
  func test_wirteData_shouldFinishSuccess() async {
    let sut = makeSUT()
    let mockTag = NFCMiFareTagMock()
    mockTag.commandResult = Data([0xFF])
    let data = Data([0xAA, 0x19])
    
    let result = await sut.write(data: data, for: mockTag)
    
    XCTAssertEqual(result, Data([0xFF]))
  }
  
  
  // MARK: - Helper Functions
  
  private func makeSUT() -> AirTag {
    let sut = AirTag()
    
    return sut
  }
  
}


class NFCMiFareTagMock: NSObject, NFCMiFareTag {
  
  enum Message {
    case sendMiFareCommand
  }
  
  private(set) var messages = [Message]()
  var commandResult: Data!
  
  func sendMiFareCommand(commandPacket command: Data, completionHandler: @escaping (Data, Error?) -> Void) {
    completionHandler(commandResult, nil)
    messages.append(.sendMiFareCommand)
  }
  
  func sendMiFareISO7816Command(_ apdu: NFCISO7816APDU, completionHandler: @escaping (Data, UInt8, UInt8, Error?) -> Void) {
    
  }
  
  var mifareFamily: NFCMiFareFamily = .desfire
  
  var identifier: Data = Data()
  
  var historicalBytes: Data?
  
  var type: __NFCTagType = .miFare
  
  var session: NFCReaderSessionProtocol?
  
  var isAvailable: Bool = false
  
  func asNFCISO15693Tag() -> NFCISO15693Tag? {
    nil
  }
  
  func asNFCISO7816Tag() -> NFCISO7816Tag? {
    nil
  }
  
  func asNFCFeliCaTag() -> NFCFeliCaTag? {
    nil
  }
  
  func asNFCMiFareTag() -> NFCMiFareTag? {
    nil
  }
  
  func queryNDEFStatus(completionHandler: @escaping (NFCNDEFStatus, Int, Error?) -> Void) {
    
  }
  
  func readNDEF(completionHandler: @escaping (NFCNDEFMessage?, Error?) -> Void) {
    
  }
  
  func writeNDEF(_ ndefMessage: NFCNDEFMessage, completionHandler: @escaping (Error?) -> Void) {
    
  }
  
  func writeLock(completionHandler: @escaping (Error?) -> Void) {
    
  }
  
  static var supportsSecureCoding: Bool = false
  
  func copy(with zone: NSZone? = nil) -> Any {
    Int()
  }
  
  func encode(with coder: NSCoder) {
    
  }
  
  required init?(coder: NSCoder) {
    
  }
  
  override init() {
    
  }
  
  
}
