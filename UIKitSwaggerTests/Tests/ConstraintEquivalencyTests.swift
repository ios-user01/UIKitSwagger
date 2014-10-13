//
//  ConstraintEquivalencyTests.swift
//  UIKitSwagger
//
//  Created by Sam Odom on 6/21/14.
//  Copyright (c) 2014 Sam Odom. All rights reserved.
//

import XCTest
import UIKit

class ConstraintEquivalencyTests: XCTestCase {

    let viewOne = UIView()
    let viewTwo = UIView()
    let differentView = UIView()
    var constraintOne: NSLayoutConstraint!
    var constraintTwo: NSLayoutConstraint!
    let equal = false

    override func setUp() {
        super.setUp()

        constraintOne = NSLayoutConstraint(item: viewOne, attribute: .Leading, relatedBy: .Equal, toItem: viewTwo, attribute: .CenterX, multiplier: 14.0, constant: 42.0)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testIdenticalConstraintsAreEqual() {
        constraintTwo = NSLayoutConstraint(item: constraintOne.firstItem, attribute: constraintOne.firstAttribute, relatedBy: constraintOne.relation, toItem: constraintOne.secondItem, attribute: constraintOne.secondAttribute, multiplier: constraintOne.multiplier, constant: constraintOne.constant)
        let equal = (constraintOne == constraintTwo)
        XCTAssertTrue(equal, "The two constraints should be considered equivalent")
    }

    func testInequalityOperatorGivenToUsForFree() {
        //  Different constraint
        constraintTwo = NSLayoutConstraint(item: differentView, attribute: constraintOne.firstAttribute, relatedBy: constraintOne.relation, toItem: constraintOne.secondItem, attribute: constraintOne.secondAttribute, multiplier: constraintOne.multiplier * 2, constant: constraintOne.constant + 10)
        var unequal = (constraintOne != constraintTwo)
        XCTAssertTrue(unequal, "The two constraints should be considered unequal")

        //  Identical constraint
        constraintTwo = NSLayoutConstraint(item: constraintOne.firstItem, attribute: constraintOne.firstAttribute, relatedBy: constraintOne.relation, toItem: constraintOne.secondItem, attribute: constraintOne.secondAttribute, multiplier: constraintOne.multiplier, constant: constraintOne.constant)
        unequal = (constraintOne != constraintTwo)
        XCTAssertFalse(unequal, "The two constraints should not be considered unequal")
    }

    func testReversedConstraintsAreEqual() {
        constraintTwo = constraintOne.reversed()
        let equal = (constraintOne == constraintTwo)
        XCTAssertTrue(equal, "The two constraints should be considered equivalent")
    }

    func testMismatchedFirstItemsMakeConstraintsUnequal() {
        constraintTwo = NSLayoutConstraint(item: differentView, attribute: constraintOne.firstAttribute, relatedBy: constraintOne.relation, toItem: constraintOne.secondItem, attribute: constraintOne.secondAttribute, multiplier: constraintOne.multiplier, constant: constraintOne.constant)
        let equal = (constraintOne == constraintTwo)
        XCTAssertFalse(equal, "The two constraints should not be considered equivalent if their first items do not match")
    }

    func testMismatchedFirstAttributesMakeConstraintsUnequal() {
        constraintTwo = NSLayoutConstraint(item: constraintOne.firstItem, attribute: .Trailing, relatedBy: constraintOne.relation, toItem: constraintOne.secondItem, attribute: constraintOne.secondAttribute, multiplier: constraintOne.multiplier, constant: constraintOne.constant)
        let equal = (constraintOne == constraintTwo)
        XCTAssertFalse(equal, "The two constraints should not be considered equivalent if their first attributes do not match")
    }

    func testMismatchedRelationsMakeConstraintsUnequal() {
        constraintTwo = NSLayoutConstraint(item: constraintOne.firstItem, attribute: constraintOne.firstAttribute, relatedBy: .GreaterThanOrEqual, toItem: constraintOne.secondItem, attribute: constraintOne.secondAttribute, multiplier: constraintOne.multiplier, constant: constraintOne.constant)
        let equal = (constraintOne == constraintTwo)
        XCTAssertFalse(equal, "The two constraints should not be considered equivalent if the relations do not match")
    }

    func testMismatchedSecondItemsMakeConstraintsUnequal() {
        constraintTwo = NSLayoutConstraint(item: constraintOne.firstItem, attribute: constraintOne.firstAttribute, relatedBy: constraintOne.relation, toItem: differentView, attribute: constraintOne.secondAttribute, multiplier: constraintOne.multiplier, constant: constraintOne.constant)
        let equal = (constraintOne == constraintTwo)
        XCTAssertFalse(equal, "The two constraints should not be considered equivalent if their second items do not match")
    }

    func testMismatchedSecondAttributesMakeConstraintsUnequal() {
        constraintTwo = NSLayoutConstraint(item: constraintOne.firstItem, attribute: constraintOne.firstAttribute, relatedBy: constraintOne.relation, toItem: constraintOne.secondItem, attribute: .Trailing, multiplier: constraintOne.multiplier, constant: constraintOne.constant)
        let equal = (constraintOne == constraintTwo)
        XCTAssertFalse(equal, "The two constraints should not be considered equivalent if their second attributes do not match")
    }

    func testMismatchedMultiplierMakeConstraintsUnequal() {
        constraintTwo = NSLayoutConstraint(item: constraintOne.firstItem, attribute: constraintOne.firstAttribute, relatedBy: constraintOne.relation, toItem: constraintOne.secondItem, attribute: constraintOne.secondAttribute, multiplier: 42, constant: constraintOne.constant)
        let equal = (constraintOne == constraintTwo)
        XCTAssertFalse(equal, "The two constraints should not be considered equivalent if their multipliers do not match")
    }

    func testMismatchedConstantsMakeConstraintsUnequal() {
        constraintTwo = NSLayoutConstraint(item: constraintOne.firstItem, attribute: constraintOne.firstAttribute, relatedBy: constraintOne.relation, toItem: constraintOne.secondItem, attribute: constraintOne.secondAttribute, multiplier: constraintOne.multiplier, constant: 99)
        let equal = (constraintOne == constraintTwo)
        XCTAssertFalse(equal, "The two constraints should not be considered equivalent if their constants do not match")
    }

}
