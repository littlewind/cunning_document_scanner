//
//  ScannerOptions.swift
//  cunning_document_scanner
//
//  Created by Maurits van Beusekom on 15/10/2024.
//

import Foundation

enum CunningScannerImageFormat: String {
    case jpg
    case png
}

enum CunningScannerSavedLocation: String {
    case cachesDirectory
    case documentDirectory
}

struct CunningScannerOptions {
    let imageFormat: CunningScannerImageFormat
    let jpgCompressionQuality: Double
    let savedLocation: CunningScannerSavedLocation
    
    init() {
        self.imageFormat = CunningScannerImageFormat.png
        self.jpgCompressionQuality = 1.0
        self.savedLocation = CunningScannerSavedLocation.cachesDirectory
    }
    
    init(imageFormat: CunningScannerImageFormat) {
        self.imageFormat = imageFormat
        self.jpgCompressionQuality = 1.0
        self.savedLocation = CunningScannerSavedLocation.cachesDirectory
    }
    
    init(imageFormat: CunningScannerImageFormat, jpgCompressionQuality: Double) {
        self.imageFormat = imageFormat
        self.jpgCompressionQuality = jpgCompressionQuality
        self.savedLocation = CunningScannerSavedLocation.cachesDirectory
    }

    init(imageFormat: CunningScannerImageFormat, jpgCompressionQuality: Double, savedLocation: CunningScannerSavedLocation) {
        self.imageFormat = imageFormat
        self.jpgCompressionQuality = jpgCompressionQuality
        self.savedLocation = savedLocation
    }
    
    static func fromArguments(args: Any?) -> CunningScannerOptions {
        if (args == nil) {
            return CunningScannerOptions()
        }
        
        let arguments = args as? Dictionary<String, Any>
    
        if arguments == nil || arguments!.keys.contains("iosScannerOptions") == false {
            return CunningScannerOptions()
        }
        
        let scannerOptionsDict = arguments!["iosScannerOptions"] as! Dictionary<String, Any>
        let imageFormat: String = (scannerOptionsDict["imageFormat"] as? String) ?? "png"
        let jpgCompressionQuality: Double = (scannerOptionsDict["jpgCompressionQuality"] as? Double) ?? 1.0
        let savedLocation: String = (scannerOptionsDict["savedLocation"] as? String) ?? "cachesDirectory"
            
        return CunningScannerOptions(
            imageFormat: CunningScannerImageFormat(rawValue: imageFormat) ?? CunningScannerImageFormat.png,
            jpgCompressionQuality: jpgCompressionQuality,
            savedLocation: CunningScannerSavedLocation(rawValue: savedLocation) ?? CunningScannerSavedLocation.cachesDirectory
        )
    }
}
