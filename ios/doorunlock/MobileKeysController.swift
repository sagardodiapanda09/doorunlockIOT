//
//  MobileKeysController.swift
//  doorunlock
//
//  Created by Arun Patel on 25/02/25.
//

import Foundation
import SeosMobileKeysSDK
import CoreLocation
import CocoaLumberjack
import AudioToolbox

class logger {
  static func d(_ message: String) {
    print("DEBUG: \(message)")
  }
}

var invitationCode = ""
//var keys = [MobileKeysKey]()
var lockServiceCodes: [Any] = []
var currentlyEnabledOpeningModes: [Any] = [MobileKeysOpeningType.motion.rawValue,MobileKeysOpeningType.proximity.rawValue,MobileKeysOpeningType.applicationSpecific.rawValue,MobileKeysOpeningType.seamless.rawValue]
var mobileKeyStartup = false
var seosIds = ""
var lastSyc = ""
var sdkVersion = ""
var seosVersion = ""
var environment = ""
var EndpointSetup = false
var roomnumber = ""
var errorDescription  = ""
var pushToken = String()
var diffrentUser = false


let LOCK_SERVICE_CODE_AAMK = 1
private let minTimeBetweenConnections: TimeInterval = 1.0

@objc(MobileKeysController)
class MobileKeysController : NSObject, MobileKeysManagerDelegate, MobileKeysMotionRecognizerDelegate, MobileKeysManagerExtendedDelegate {
  @objc var keys = [MobileKeysKey]()
  private var mobileKeysManager : MobileKeysManager?
  //    private var locationManager: CLLocationManager?
  private var applicationIsStarting = false
  private var seosId: Int = 0
//  private var currentlyEnabledOpeningModes: [Any] = []
  //    let appDelegat = UIApplication.shared.delegate as! AppDelegate
  private var timeOfLastConnection: Date?
  var scanningCheck = false
  @objc static let sharedInstance = MobileKeysController()
  
  
  // MARK: - initialize the Seos SDK for open the Lock
  override init() {
      super.init()
      // Create the MobileKeysManager
      mobileKeysManager = createInitializedMobileKeysManager()
      
//        locationManager = CLLocationManager()
//        locationManager?.requestWhenInUseAuthorization()
  }
  
  
  @objc func sendSeosSdkEvent(eventName: String, eventData: Any) {
    let eventBody: [String: Any] = ["withName": eventName, "body": eventData]
    
    DispatchQueue.main.async {
      if let eventEmitter = RCTBridge.current()?.module(forName: "SeosMobileKeysModule") as? SeosMobileKeysModule {
        eventEmitter.emitEvent(withName: "onMessageFromSeos", body: eventBody) // ✅ Call the instance method
      } else {
        logger.d("Error: SeosMobileKeysModule is not initialized")
      }
    }
  }
  
 @objc func createInitializedMobileKeysManager() -> MobileKeysManager? {
      let version = "EXAMPLE-\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.1") (\(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"))"
      let config = [
          MobileKeysOptionApplicationId: "EXAMPLE",
          MobileKeysOptionVersion: version
      ]
      
      logger.d("config : \(config)")
      
      return MobileKeysManager(delegate: self , options: config)
  }
  
  @objc func start() {
      if let api = mobileKeysManager?.apiVersion() {
          logger.d("Using SDK version \(api)")
          sdkVersion = api
      }
      if isEndpointSetup() {
          logger.d("Personalized and showing KeyView")
          applicationIsStarting = true
          var listKeysError: NSError?
          logger.d("Starting application")
          EndpointSetup = true
          if mobileKeysManager?.listMobileKeys(&listKeysError).count ?? 0 > 0 {
                  keys = getTheMobileKeys()
          }
          // check if user is different or not
          if let diffUser = UserDefaults.standard.value(forKey: "diffrentUser") as? Bool {
              diffrentUser = diffUser
          }
      } else {
          EndpointSetup = false
          logger.d("Not Personalized, showing PersonalizationView")
      }
      // The startup will either give a callback to "mobileKeysDidStartup" or "mobileKeysDidFailToStartup"
      mobileKeysManager?.startup()
  }
  
  // MARK: Mobile Keys API method
  func isEndpointSetup() -> Bool {
      let error: Error?
      var setupComplete = Bool()
      do {
          setupComplete  = ((try mobileKeysManager?.isEndpointSetup()) != nil)
      }catch{
          logger.d("\(error)")
          logger.d("Error in setupComplete")
      }
      
      // try self.handleError(error: error!)
      return setupComplete
  }

  
  
  // The example app simply DDLogebugs errors to the log
  func handleError(error: Error) throws {
      if error != nil {
          logger.d(String(format: "ERROR %lxd : %@", Int(error._code ), error.localizedDescription ))
      }
  }
  
  @objc func didPressRegistrationButton(_ code: String?) {
      // registrationViewController?.registrationButton.enabled = false
    logger.d("Personalizing... \(String(describing: code))")
      // The setup will either give a callback to "mobileKeysDidSetup" or "mobileKeysDidFailToSetup"
      mobileKeysManager?.setupEndpoint(code!)
      
  }
  
  
  // MARK: - EndPoint regarding all methods.
  func mobileKeysDidStartup() {
      logger.d("mobileKeysDidStartup")
      mobileKeyStartup = true
      setupEndpoint()
      //  cacheSeosId()
  }
  
  @objc func setupEndpoint() {
      if isEndpointSetup() {
          logger.d("Updating EndPoint")
          // The update will either give a callback to "mobileKeysDidUpdate" or "mobileKeysDidFailToUpdate"
          mobileKeysManager?.updateEndpoint()
      }
  }
  
  func mobileKeysDidFail(toStartup error: Error) {
      logger.d("mobileKeysDidFail")
  }
  
  func mobileKeysDidUpdateEndpoint() {
      logger.d("mobileKeysDidUpdateEndpoint")
  }
  
  func mobileKeysDidUpdateEndpoint(with endpointUpdateSummary: MobileKeysEndpointUpdateSummary) {
    //    NotificationCenter.default.post(name: Notification.Name("mobileKeysDidUpdateEndpoint"), object: nil)
    logger.d("mobileKeysDidUpdateEndpoint update summary \(endpointUpdateSummary)")
    self.sendSeosSdkEvent(eventName: "mobileKeysDidUpdateEndpoint", eventData: "mobile key did update end point")
  }
  
  func mobileKeysDidFail(toUpdateEndpoint error: Error) {
    logger.d("mobileKeysDidFail to UpdateEndpoint \(error)")
  }
  
  
  func mobileKeysDidFail(toSetupEndpoint error: Error) {
    logger.d("mobileKeysDidFailtoSetupEndpoint \(error)")
    //    SeosMobileKeysModule.emitEvent(withName: "mobileKeysDidFailtoSetupEndpoint", body: "mobile key setup up end point fail")
    self.sendSeosSdkEvent(eventName: "mobileKeysDidFailtoSetupEndpoint", eventData: "mobile key setup up end point fail")
  }
  
  func mobileKeysDidTerminateEndpoint() {
    logger.d("mobileKeysDidTerminateEndpoint")
    self.sendSeosSdkEvent(eventName: "mobileKeysDidTerminateEndpoint", eventData: "mobile Keys Did Terminate Endpoint")
  }
  
  
  
  func mobileKeysDidSetupEndpoint() {
      logger.d("mobileKeysDidSetupEndpoint")
      logger.d("\(isEndpointSetup())")
      self.sendSeosSdkEvent(eventName: "mobileKeysDidSetupEndpointtoStartup", eventData: "mobile Keys Did Setup Endpoint to Startup")
      if isEndpointSetup() {
          logger.d("setup Done")
          EndpointSetup = true
          cacheSeosId()
      }
  }
  
  func unregisterEndpoint() {
    logger.d("unregisterEndpoint")
    mobileKeysManager?.unregisterEndpoint()
  }
  
  @objc func getTheMobileKeys() ->  [MobileKeysKey] {
    logger.d("gereateTheMobileKeys function called")
    var error: NSError?
    var listKeysError: NSError?
    var keys = [MobileKeysKey]()
    if self.mobileKeysManager?.listMobileKeys(&listKeysError).count ?? 0 > 0 {
      keys = self.mobileKeysManager?.listMobileKeys(&error) ?? []
    }else{
      keys = []
    }
    logger.d("keys data \(self.mobileKeysManager?.listMobileKeys(&error).count ?? 0)")
    logger.d("Error is \(error)")
    return keys
  }
  
  func refreshTheKeys() {
    keys = getTheMobileKeys()
  }
  
  
  func cacheSeosId() {
    if seosId == 0 {
      let error: Error? = nil
      let endpointInfo: MobileKeysEndpointInfo? = mobileKeysManager?.endpointInfo(error as? AutoreleasingUnsafeMutablePointer<NSError?>)
      seosId = Int(endpointInfo?.seosId ?? 0)
      seosVersion = (endpointInfo?.seosAppletVersion)!
      // logger.d("\(endpointInfo?.environmentType)")
      lastSyc =  (endpointInfo?.lastServerSyncDate.description)!
      seosIds =  seosId.description
      logger.d(String(format: "Cached Seos ID: %lu", UInt(seosId)))
    }
  }
  
  func bluetoothStatus() -> Bool {
    return mobileKeysManager?.deviceHasBluetoothTurnedOn() ?? false
  }
  
  // MARK: Mobile Keys Bluetooth API example implementation
  @objc func toggleScanning() -> Bool {
    var listKeysError: NSError?
    let openingTypes: [Any] = currentlyEnabledOpeningModes;
    let scanMode = MobileKeysScanMode.optimizePowerConsumption;
    lockServiceCodes = [Int(keys[0].cardNumber.description) ?? 1]
    logger.d("Bluetooth \(MobileKeysErrorCode.bluetoothLENotAvailable)")
    
    logger.d("\(MobileKeysOpeningType.applicationSpecific.rawValue)\(MobileKeysOpeningType.proximity.rawValue)\(MobileKeysOpeningType.seamless.rawValue)")
    
    
    let openingtype : [Any] = [1,2,8]
    
    if mobileKeysManager?.listMobileKeys(&listKeysError).count ?? 0 > 0 {
      logger.d("Scanning mode \(String(describing: mobileKeysManager?.isScanning()))")
      let scanningtype : Bool = ((mobileKeysManager?.isScanning) != nil)
      if scanningtype == false {
        logger.d("Restart scanning")
        mobileKeysManager?.stopReaderScan()
      } else {
        scanningCheck = true
        logger.d("Start scanning")
      }
      var error: NSError?
      if mobileKeysManager?.listMobileKeys(&error).count ?? 0 > 0 {
        
        logger.d("scanMode : \(scanMode),  supportedOpeningTypes : \(openingTypes), lockServiceCodes \(lockServiceCodes)")
        do {
          try mobileKeysManager?.startReaderScan(in: MobileKeysScanMode.optimizePerformance, supportedOpeningTypes: openingTypes ?? openingtype, lockServiceCodes: lockServiceCodes)
        }catch {
          logger.d("catch block")
        }
        
        
      } else {
        logger.d("Error in scanning : \(String(describing: error?.description))")
      }
      
      if error != nil {
        switch (error as NSError?)?.code {
        case Int(Float(MobileKeysErrorCode.bluetoothLENotAvailable.rawValue))?:
          logger.d("Couldn't start scan due BLE being off or not available")
          //AlertManager.sharedInstance.alert(messages: "Couldn't start scan due Bluetooth being off or not available. Please Enable Bluetooth for start scanning.")
          return false
        default:
          try? self.handleError(error: error!)
        }
      }else{
        logger.d("No error occurred")
        return true
      }
      
    } else {
      
      logger.d("No keys - stopped scanning")
      mobileKeysManager?.stopReaderScan()
      //try? self.handleError(error: error!)
    }
    return true
  }
  
  @objc func scanningState() -> Bool {
    let scanningtype : Bool = ((mobileKeysManager?.isScanning) != nil)
    return scanningtype
  }
  
  
  func stopScanning() {
    mobileKeysManager?.stopReaderScan()
  }
  
  func userMadeUnlockGesture(_ openingType: MobileKeysOpeningType) {
    logger.d("opening type is \(openingType)")
  }
  
  
  // MARK: Logging
  func constructLogMessage(_ reader: MobileKeysReader?, with type: MobileKeysOpeningType, openingStatus status: MobileKeysOpeningStatusType) -> String? {
    var readerAddress = "none"
    let openingStatus = openingStatusType(toString: status)
    let openingType = self.openingType(toString: type)
    if reader != nil {
      let readerUid = reader?.uuid
      readerAddress = shortenReaderUid(readerUid) ?? ""
    }
    return "Reader: \(readerAddress). Status: \(openingStatus ?? ""). Type: \(openingType ?? "")."
  }
  
  func shortenReaderUid(_ readerUid: String?) -> String? {
    return (readerUid as NSString?)?.substring(from: (readerUid?.count ?? 0) - 8)
  }
  
  func openingType(toString type: MobileKeysOpeningType) -> String? {
    switch type {
    case MobileKeysOpeningType.proximity:
      return "Proximity"
    case MobileKeysOpeningType.motion:
      return "Motion"
    case MobileKeysOpeningType.seamless:
      return "Seamless"
    case MobileKeysOpeningType.unknown:
      return "Unknown"
    case MobileKeysOpeningType.applicationSpecific:
      return "App Specific"
    default:
      return "none"
    }
  }
  
  func openingStatusType(toString statusType: MobileKeysOpeningStatusType) -> String? {
    switch statusType {
    case MobileKeysOpeningStatusType.success :
      return "Success"
    case MobileKeysOpeningStatusType.timedOut:
      return "Timed out"
    case MobileKeysOpeningStatusType.outOfRange:
      return "Out of range"
    case MobileKeysOpeningStatusType.busy:
      return "Busy"
    case MobileKeysOpeningStatusType.motionNotSupported:
      return "Motion not supported"
    default:
      return "Unknown status"
    }
    
  }
  
  
  // MARK: Mobile Keys Bluetooth Protocol example callback handlers
  func mobileKeysDidConnect(to reader: MobileKeysReader, openingType type: MobileKeysOpeningType) {
    let logEntry = "Connected. \(constructLogMessage(reader, with: type, openingStatus: MobileKeysOpeningStatusType.success) ?? "")"
    logger.d("mobileKeysDidConnect")
    DispatchQueue.main.async(execute: {
      logger.d(logEntry)
    })
    
    
    
    var enoughTimeHasPassed: Bool? = nil
    if let timeOfLastConnection = timeOfLastConnection {
      enoughTimeHasPassed = Date().timeIntervalSince(timeOfLastConnection) > minTimeBetweenConnections
    }
    if enoughTimeHasPassed ?? false {
      // giveConnectionFeedbackToUser()
      logger.d("enoughTimeHasPassed")
    }
    timeOfLastConnection = Date()
    
  }
  
  func mobileKeysDidFailToConnect(to reader: MobileKeysReader, openingType type: MobileKeysOpeningType, openingStatus status: MobileKeysOpeningStatusType) {
    logger.d("mobileKeysDidFailToConnect")
  }
  
  
  func mobileKeysDidDisconnect(from reader: MobileKeysReader, openingType type: MobileKeysOpeningType, openingResult result: MobileKeysOpeningResult) {
    var logEntry: String? = nil
    let status = result.status
    logEntry = "Disconnected. \(constructLogMessage(reader, with: type, openingStatus: status) ?? "")"
    
    var statusDetailsLogEntry: String? = nil
    if let statusPayload = result.statusPayload {
      statusDetailsLogEntry = "Disconnect payload: \(statusPayload)"
      if let datas = statusPayload as? NSData {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                        if datas.didUnlock() {
//                            NotificationCenter.default.post(name: Notification.Name("Unlocked"), object: nil)
                            sendSeosSdkEvent(eventName: "Unlock", eventData: "door unlocked successfull")
                            // AlertManager.sharedInstance.alert(messages: "Lock is succesfully opened.")
                            logger.d("Lock is succesfully opened.")
                            scanningCheck = false
                        }else{
                            scanningCheck = false
                            logger.d("Sorry! Unable to unlock. \(statusDetailsLogEntry ?? "")")
                            var errorCode = String(format:"%02X", (result.statusPayload as NSData).detailedDidNotUnlockReason().rawValue)
                            if errorCode.count == 1 {
                                errorCode = "0x000" + errorCode
                            } else if errorCode.count == 2 {
                                errorCode = "0x00" + errorCode
                            } else {
                                errorCode = "0x0" + errorCode
                            }
                            logger.d("converted to hex \(errorCode)")
//                            NotificationCenter.default.post(name: Notification.Name("DidNotUnlock"), object: errorCode)
                          sendSeosSdkEvent(eventName: "DidNotUnlock", eventData: errorCode)
                        }
      }
      
      
    }
    DispatchQueue.main.async(execute: {
      logger.d(logEntry ?? "mobileKeysDidDisconnect")
      logger.d(statusDetailsLogEntry ?? "mobile Keys DidDisconnect")
    })
  }
  
  // MARK: Reader management example callback handlers
  
  
  
  func mobileKeysShouldAttempt(toOpen reader: MobileKeysReader, openingType type: MobileKeysOpeningType) -> Bool {
    logger.d("mobileKeysShouldAttempt")
    return true
  }
  
  func mobileKeysShouldInteract(withScannedReader mobileKeysReader: MobileKeysReader) -> Bool {
    var returns = Bool()
    if scanningCheck == true {
      logger.d("mobileKeysShouldInteract \(mobileKeysReader.latestRssiMeasurement.rssiValue)")
      logger.d("Reader data :- readerCanConnect : \(mobileKeysReader.readerCanConnect) \noptionalScanResponseData : \(mobileKeysReader.optionalScanResponseData) \nreaderType : \(mobileKeysReader.readerType) \nrssiHistory : \(mobileKeysReader.rssiHistory()?.description) \nsupportedOpeningTypes : \(mobileKeysReader.supportedOpeningTypes)")
      var error: NSError?
      var range = Int()
      if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
        range = -60
        logger.d("ipad")
      }else{
        range = -40
        logger.d("iphone")
      }
      logger.d("rssi value \(mobileKeysReader.latestRssiMeasurement.rssiValue)   connect range \(range)")
      if mobileKeysReader.latestRssiMeasurement.rssiValue >= range {
        logger.d("Door unlock connected.\(mobileKeysReader.latestRssiMeasurement.rssiValue)")
        
        do {
          try self.mobileKeysManager?.connect(to: mobileKeysReader, openingType: MobileKeysOpeningType.applicationSpecific)
        }catch{
          logger.d("catch block")
        }
        
        
        if error != nil {
          if let description = error?.localizedDescription {
            logger.d("Error calling connectoToReader: \(description)")
          }
        }
        returns = true
      }else{
        returns = false
      }
    }
    return returns
  }
  
  
  // MARK: Motion Detector example callback handler
  func mobileKeysUserDidUnlockGesture() {
    DispatchQueue.main.async(execute: {
      logger.d("mobileKeysDidUnlockGesture")
    })
  }
  
  
  func userMadeUnlockGesture() {
    logger.d("userMadeUnlockGesture")
  }
}
