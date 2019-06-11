//
//  Global.swift
//  Learning
//
//  Created by Playground, Inc. on 2018/09/17.
//  Copyright © 2018 Playground, Inc.. All rights reserved.
//


import UIKit

public let WIDTH: CGFloat = {
    var result: CGFloat = 0.0
    if let first = UIApplication.shared.windows.first {
        result = first.frame.width
    }
    return result
}()

public let HEIGHT: CGFloat = {
    var result: CGFloat = 0.0
    if let first = UIApplication.shared.windows.first {
        result = first.frame.height
    }
    return result
}()

// MARK: - ***** FUNCTION **********

public func propertyNames(owner: Any) -> [String] {
    return Mirror(reflecting: owner).children.compactMap{ $0.label }
}

public func transitionViewController(from: UIViewController, to: UIViewController, animated: Bool? = true) {
    if let navigationController = from.navigationController,
        let animated = animated {
        navigationController.pushViewController(to, animated: animated)
    }
}

public func popViewController(owner: UIViewController, animated: Bool? = true) {
    if let navigationController = owner.navigationController,
        let animated = animated {
        navigationController.popViewController(animated: animated)
    }
}

public func transitionStoryboard(name: String) {
    if let window = UIApplication.shared.windows.first {
        let  storyboard: UIStoryboard = UIStoryboard(name: name, bundle: Bundle.main)
        window.rootViewController = storyboard.instantiateInitialViewController()
        window.makeKeyAndVisible()
    }
}

public func loadViewFromXib(withOwner: Any) -> [Any]? {
    let name = getClassName(fromObject: withOwner)
    let nib: UINib = UINib.init(nibName: name, bundle: nil)
    let result: [Any]? = nib.instantiate(withOwner: withOwner, options: nil)
    return result
}

public func loadTableViewCellFromXib(tableView: UITableView, cellName: String) {
    let nib = UINib.init(nibName: cellName, bundle: nil)
    tableView.register(nib, forCellReuseIdentifier: cellName)
    
}

public func loadCollectionViewCellFromXib(collectionView: UICollectionView, cellName: String) {
    let nib = UINib.init(nibName: cellName, bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: cellName)
}

public func setCollectionViewLayout(collectionView: UICollectionView, columnCount: Double, heithRatio: Double, direction: UICollectionView.ScrollDirection) -> Double {
    let flowLayout = UICollectionViewFlowLayout()
    let margin: CGFloat = 0.0
    let cellWidth = Double(WIDTH) / columnCount
    let cellHeight = cellWidth * heithRatio
    flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    flowLayout.scrollDirection = direction
    flowLayout.minimumInteritemSpacing = margin
    flowLayout.minimumLineSpacing = margin
    flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    collectionView.collectionViewLayout = flowLayout
    return cellHeight
}

public func setTabBarTintColor(tabBar: UITabBar, colorHex: String) {
    tabBar.barTintColor = UIColor(hex: colorHex)
}

public func setNavigationBarColor(navigationBar: UINavigationBar,
                           colorHex: String) {
    navigationBar.barTintColor = UIColor(hex: colorHex)
}

public func getClassName(fromObject: Any) -> String {
    let moduleName = NSStringFromClass(type(of: fromObject) as! AnyClass)
    let startIndex = moduleName.index(of: ".")!
    let indexAfterModuleName = moduleName.index(after: startIndex)
    let classname = moduleName[indexAfterModuleName...]
    return String(classname)
}

public func setShadow<Object: UIView>(_ object: Object, color: CGColor, shadowRadius: CGFloat) {
    object.layer.shadowColor = color
    object.layer.shadowOpacity = 0.5
    object.layer.shadowOffset = CGSize(width: 5, height: 5)
    object.layer.shadowRadius = shadowRadius
}

public func setCornerRadius<Object: UIView>(_ object: Object, radius: CGFloat) {
    object.layer.cornerRadius = radius
}

public func getDocumentPath() -> String {
    let d_paths = NSSearchPathForDirectoriesInDomains(
        .documentDirectory,
        .userDomainMask, true)
    let documentsPath = d_paths[0]
    return documentsPath
}

public func getLibraryCachePath() -> String {
    let c_paths = NSSearchPathForDirectoriesInDomains(
        .cachesDirectory,
        .userDomainMask, true)
    let cachesPath = c_paths[0]
    return cachesPath
}

public func getTemporaryPath() -> String {
    let tmpPath = NSTemporaryDirectory()
    return tmpPath
}

public func parsePlist(_ fileName: String) -> [[String: Any]]? {
    guard let filePath: URL = Bundle.main.url(forResource: fileName, withExtension: "plist") else {
        return nil
    }
    do {
        let data = try Data(contentsOf: filePath)
        return try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String: Any]]
    }
    catch {
        return nil
    }
}

public func randomString(length: Int) -> String {
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    var randomString = ""
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    return randomString
}

public func getUUID() -> String? {
    var result: String?
    if let vendor = UIDevice.current.identifierForVendor {
        result = vendor.uuidString
    }
    return result
}

public func getOS() -> String {
    let result = UIDevice.current.systemVersion
    return result
}

public func getModel() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }

    func mapToDevice(identifier: String) -> String {
        #if os(iOS)
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad7,5", "iPad7,6":                      return "iPad 6"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
        default:                                        return identifier
        }
        #elseif os(tvOS)
        switch identifier {
        case "AppleTV5,3": return "Apple TV 4"
        case "AppleTV6,2": return "Apple TV 4K"
        case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
        default: return identifier
        }
        #endif
    }
    return mapToDevice(identifier: identifier)
}
