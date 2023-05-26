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
    let mockTag = MyNFCMiFareTagMock()
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


class MyNFCMiFareTagMock: MyNFCMiFareTag {

  
  
  enum Message {
    case sendMiFareCommand
  }
  
  private(set) var messages = [Message]()
  var commandResult: Data!
  
  func sendMiFareCommand(commandPacket command: Data, resultHandler: @escaping (Result<Data, Error>) -> Void) {
    resultHandler(.success(commandResult))
    messages.append(.sendMiFareCommand)
  }
  
}
