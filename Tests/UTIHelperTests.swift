//
//  UTIHelperTests.swift
//  WireUtilities-Tests
//
//  Created by bill on 02.08.21.
//

import XCTest

final class UTIHelperTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testThatconformsToVectorTypeIdentifiesSVG() {
        //given, when, then
        XCTAssert(UTIHelper.conformsToVectorType(uti: "public.svg-image"))
    }
    
    func testThatConformsTypeIdentifiesJSONIsNotImageOrVectorType() {
        //given
        let sut = "public.json"
        
        //when & then
        XCTAssertFalse(UTIHelper.conformsToImageType(uti: sut))
        XCTAssertFalse(UTIHelper.conformsToVectorType(uti: sut))
        
        XCTAssert(UTIHelper.conformsToJsonType(uti: sut))
    }
    
    func testThatConformsToImageTypeIdentifiesCommonImageTypes() {
        //given
        let suts = ["public.jpeg",
                    "com.compuserve.gif",
                    "public.png",
                    "public.svg-image"]
        
        suts.forEach() { sut in
            //when & then
            XCTAssert(UTIHelper.conformsToImageType(uti: sut), "\(sut) does not conorms to image type")
        }
    }
    
    func testThatConvertToUtiConvertsCommonImageTypes() {
        
        //given & when & then
        XCTAssertEqual(UTIHelper.convertToUti(mime: "image/jpeg"), "public.jpeg")
        XCTAssertEqual(UTIHelper.convertToUti(mime: "image/gif"), "com.compuserve.gif")
        XCTAssertEqual(UTIHelper.convertToUti(mime: "image/png"), "public.png")
        XCTAssertEqual(UTIHelper.convertToUti(mime: "image/svg+xml"), "public.svg-image")
    }
    
    func testThatConvertToMimeConvertsCommonImageTypes() {
        //given & when & then
        XCTAssertEqual(UTIHelper.convertToMime(uti: "public.jpeg"), "image/jpeg")
        XCTAssertEqual(UTIHelper.convertToMime(uti: "com.compuserve.gif"), "image/gif")
        XCTAssertEqual(UTIHelper.convertToMime(uti: "public.png"), "image/png")
        XCTAssertEqual(UTIHelper.convertToMime(uti: "public.svg-image"), "image/svg+xml")
                
    }
}
