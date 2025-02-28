//
//  NSData+Exstensions.swift
//  PDKey
//
//  Created by Kasper Blom on 2018-09-03.
//  Copyright © 2018 Igor Stevstedt. All rights reserved.
//

import Foundation

@objc enum ReaderResultDataFormat: Int {
    case standard = 0x01,
    unknown = -1
}

@objc enum UnlockReason: Int {
    case openedByGuestKey = 0x01,
    openedByStaffKey = 0x10,
    openedBySpecialKey = 0x20,
    notApplicable = -1
}

@objc enum DidNotUnlockReason: Int {
    case keyIsOverridden = 0x40,
    keyIsNotValidYet = 0x41,
    keyHasExpired = 0x42,
    keyIsCancelled = 0x43,
    keyGroupIsBlocked = 0x44,
    keyHasNoAccessToThisRoom = 0x45,
    keyHasNoAccessToThisFacility = 0x46,
    keyNotValidAtThisTimeOfDay = 0x47,
    keyBlockedBecauseOfDeadbolt = 0x48,
    keyBlockedBecauseOfRoomPrivacySetting = 0x49,
    keyBlockedBecauseOfDoorBatteryLevel = 0x4a,
    keyBlockedByAntiPassbackFunction = 0x4b,
    keyRefusedBecauseDoorIsNotLocked = 0x4c,
    keyRefusedDueToPINCode = 0x4d,
    keyBlockedByAccessRules = 0x4e,
    notApplicable = -1
}


@objc enum DetailedUnlockReason: Int {
    // MARK: 0x01 Door opened by guest key
    case openingWithGuestCard = 0x0043,
    openingWithGuestSuiteCard = 0x0044,
    openingByGuestInCommonRoom = 0x0045,
    openingWithFutureArrivalCard = 0x0046,
    openingWithOneTimeCard = 0x0048,
    openingByGuestInEntranceDoor = 0x0049,
    
    // MARK: 0x10 Door opened by staff key
    openingWithStaffCard = 0x0040,
    
    // MARK: 0x20 Door opened by special key
    standOpenSet = 0x0041,
    openingWithPowerDownCard = 0x0047,
    openingWithNTimeCard = 0x004a,
    
    notApplicable = -1
}

@objc enum DetailedDidNotUnlockReason: Int {
    // MARK: 0x40 Key is overridden
    case guestCardOverridden = 0x0010,
    guestCardOverridden_v2 = 0x0011,
    
    // MARK: 0x41 Key is not valid yet
    cardNotValidYet = 0x0012,
    
    // MARK: Key has expired
    cardHasExpired = 0x0142,
    
    // MARK: 0x43 Key is cancelled
    cardCancelled = 0x0017,
    
    // MARK: 0x44 Key group is blocked
    cardUsergroupBlocked = 0x0018,
    
    // MARK: 0x45 Key has no access to this room
    noAccessToThisRoom = 0x0140,
    
    // MARK: 0x46 Key has no access to this hotel
    wrongSystemNumberOnCard = 0x0105,
    
    // MARK: 0x47 Key not valid at this time of day
    notValidAtThisTime = 0x0016,
    cardOnlyValidDuringOpeningTime = 0x0020,
    
    // MARK: 0x48 Key blocked becuase of deadbolt
    doorUnitDeadBolted = 0x0021,
    doorUnitDeadBoltedGuest = 0x0022,
    doorUnitDeadBoltedFamily = 0x0023,
    
    // MARK: 0x49 Key blocked becuase of room privacy setting
    notValidDueToPrivacyStatus = 0x0026,
    notValidDueToPrivacyStatusSilent = 0x0027,
    notValidDueToDoNotDisturbStatus = 0x002b,
    
    // MARK: 0x4a Key blocked because of battery level
    accessDeniedDueToBatteryAlarm = 0x0035,
    
    // MARK: 0x4b Key blocked by anti passback function
    notValidDueToAntiPassback = 0x0015,
    
    // MARK: 0x4c Key refused because door is not locked
    notValidDueToDoorNotClosed = 0x0024,
    notValidDueToOpenStatus = 0x0025,
    
    // MARK: 0x4d Key refused due to PIN code
    wrongPIN = 0x0013,
    wrongPIN_v2 = 0x0019,
    
    // MARK: 0x4e Blocked by access rules
    commandNotValidForThisLock = 0x001a,
    counterValueTooLow = 0x0014,
    notValidDueToPassageRevoked = 0x0028,
    
    notApplicable = -1
}

@objc enum ReaderBatteryStatus: Int {
    case good = 0x00,
    warning = 0x01,
    critical = 0x02,
    
    invalid = -1
}

@objc enum AccessControlSystem: Int {
    case visionline = 0x01,
    
    unknown = -1
}
@objc extension NSData {
    func containsData() -> Bool {
        return self.length>0
    }
    
    func didUnlock() -> Bool {
        if !self.containsData() {
            return false
        }
        
        let result = self.partialResultFrom(location: 1, length: 1)
        let myScanner = Scanner(string: result)
        var unlockedStatusValue: UInt64 = 0
        myScanner.scanHexInt64(&unlockedStatusValue)
        if unlockedStatusValue > 0 {
            return true
        } else {
            return false
        }
    }
    
    func unlockReason() -> UnlockReason {
        var reason = UnlockReason.notApplicable
        if !self.containsData() {
            return reason
        }
        
        let result = self.partialResultFrom(location: 2, length: 1)
        if (!result.isEmpty) {
            let myScanResult = self.scanStringforResult(string: result)
            if myScanResult.success {
                if let theReason = UnlockReason.init(rawValue: myScanResult.resultInt) {
                    reason = theReason
                }
            }
        }
        return reason
    }
    
    func didNotUnlockReason() -> DidNotUnlockReason {
        var reason = DidNotUnlockReason.notApplicable
        if !self.containsData() {
            return reason
        }
        
        let result = self.partialResultFrom(location: 2, length: 1)
        if (!result.isEmpty) {
            let myScanResult = self.scanStringforResult(string: result)
            if myScanResult.success {
                if let theReason = DidNotUnlockReason(rawValue: myScanResult.resultInt) {
                    reason = theReason
                }
            }
        }
        return reason
    }
    
    func detailedUnlockReason() -> DetailedUnlockReason {
        var reason = DetailedUnlockReason.notApplicable
        if !self.containsData() {
            return reason
        }
        
        let result = self.partialResultFrom(location: 9, length: 2)
        if (!result.isEmpty) {
            let myScanResult = self.scanStringforResult(string: result)
            if myScanResult.success {
                if let theReason = DetailedUnlockReason(rawValue: myScanResult.resultInt) {
                    reason = theReason
                }
            }
        }
        return reason
    }
    
    func detailedDidNotUnlockReason() -> DetailedDidNotUnlockReason {
        var reason = DetailedDidNotUnlockReason.notApplicable
        if !self.containsData() {
            return reason
        }
        
        let result = self.partialResultFrom(location: 9, length: 2)
        if (!result.isEmpty) {
            let myScanResult = self.scanStringforResult(string: result)
            if myScanResult.success {
                if let theReason = DetailedDidNotUnlockReason(rawValue: myScanResult.resultInt) {
                    reason = theReason
                }
            }
        }
        return reason
    }
    
    func doorId() -> String {
        var doorIdResult = ""
        if !self.containsData() {
            return doorIdResult
        }
        
        let result = self.partialResultFrom(location: 3, length: 4)
        if (!result.isEmpty) {
            let myScanResult = self.scanStringforResult(string: result)
            if myScanResult.success {
                doorIdResult = String.init(format: "%ld", myScanResult.resultInt)
            }
        }
        return doorIdResult
    }
    
    func readerBatteryStatus() -> ReaderBatteryStatus {
        var status = ReaderBatteryStatus.invalid
        if !self.containsData() {
            return status
        }
        
        let result = self.partialResultFrom(location: 7, length: 1)
        if (!result.isEmpty) {
            let myScanResult = self.scanStringforResult(string: result)
            if myScanResult.success {
                if let theStatus = ReaderBatteryStatus(rawValue: myScanResult.resultInt) {
                    status = theStatus
                }
            }
        }
        return status
    }
    
    func accessControlSystem() -> AccessControlSystem {
        var system = AccessControlSystem.unknown
        if !self.containsData() {
            return system        }
        
        let result = self.partialResultFrom(location: 8, length: 1)
        if (!result.isEmpty) {
            let myScanResult = self.scanStringforResult(string: result)
            if myScanResult.success {
                if let theSystem = AccessControlSystem(rawValue: myScanResult.resultInt) {
                    system = theSystem
                }
            }
        }
        return system
    }
    
    func firmwareVersionLCU() -> String {
        var versionLcu = ""
        if !self.containsData() {
            return versionLcu
        }
        
        let result = self.partialResultFrom(location: 11, length: 4)
        if (!result.isEmpty && result.count > 7) {
            let resMajor = self.substringWithRange(from: result, startPos: 0, length: 1*2)
            let resMinor = self.substringWithRange(from: result, startPos: 1*2, length: 1*2)
            let resRevision = self.substringWithRange(from: result, startPos: 2*2, length: 1*2)
            let resBuild = self.substringWithRange(from: result, startPos: 3*2, length: 1*2)
            
            let stringResult = ""
            versionLcu = stringResult.appendingFormat("%@.%@.%@ (%@)", resMajor, resMinor, resRevision, resBuild)
        }
        return versionLcu
    }
    
    func firmwareVersionBLE() -> String {
        var versionBLE = ""
        if !self.containsData() {
            return versionBLE
        }
        
        let result = self.partialResultFrom(location: 15, length: 2)
        if (!result.isEmpty && result.count > 3) {
            let resMajor = self.substringWithRange(from: result, startPos: 0, length: 1*2)
            let resMinor = self.substringWithRange(from: result, startPos: 1*2, length: 1*2)
            
            let stringResult = ""
            versionBLE = stringResult.appendingFormat("%@.%@", resMajor, resMinor)
        }
        return versionBLE
    }
    
    func RFU() -> String { return "" }
    
    // MARK: - functions for converting NSData to HexString and HexString to NSData
    func toStringHex() -> String {
        return self.byteArrayAsHexString()
    }
    
    public static func dataFromHexString(_ hexString:String) -> NSData {
        
        let len = hexString.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hexString.index(hexString.startIndex, offsetBy: i*2)
            let k = hexString.index(j, offsetBy: 2)
            let bytes = hexString[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                data = Data()
                break;
            }
        }
        
        let nsData = data as NSData
        return nsData
    }
    
    // MARK: - private implementations for extracting data.
    private func byteArrayAsHexString() -> String {
        var resultAsHexBytes = ""
        
        let data = self as Data
        data.forEach { (anUint8) in
            // do code
            resultAsHexBytes = resultAsHexBytes.appendingFormat("%02x", anUint8)
        }
        return resultAsHexBytes
    }

    private func substringWithRange(from myString:String, startPos:Int, length: Int) -> String {
        let indexStartOfText = myString.index(myString.startIndex, offsetBy: startPos)
        let indexEndOfText = myString.index(indexStartOfText, offsetBy: length)
        let range = indexStartOfText..<indexEndOfText
        let mySubString = myString[range]
        return String(mySubString)
    }
    
    private func partialResultFrom(location pos:Int, length: Int) -> String {
        var aResult = ""
        
        let bufferAsString = self.byteArrayAsHexString()
        
        let aRange = NSRange(location: pos*2, length: length*2)
        let formatRange = NSRange(location: 0, length: 1*2)
        
        if let rangedString = Range<String.Index>(aRange, in: bufferAsString) {
            if let dataFormatString = Range<String.Index>(formatRange, in: bufferAsString) {
                let format = 1
                let formatStandard = String.init(format: "%02x", format)
                if String(bufferAsString[dataFormatString]) == formatStandard {
                    aResult = String(bufferAsString[rangedString])
                }
            }
        }
        return aResult
    }
    
    @nonobjc private func scanStringforResult(string hexString: String) -> (success:Bool, resultInt: Int) {
        let myScanner = Scanner(string: hexString)
        var resultAsValue: UInt64 = 0
        if myScanner.scanHexInt64(&resultAsValue) {
            let resultInt = Int(resultAsValue)
            return (true, resultInt)
        } else {
            return (false, 0)
        }
    }
}








