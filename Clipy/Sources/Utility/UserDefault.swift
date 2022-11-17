//
//  UserDefault.swift
//
//  Clipy
//  GitHub: https://github.com/clipy
//  HP: https://clipy-app.com
//
//  Created by nelson.wu on 2022/11/16.
//
//  Copyright © 2015-2022 Clipy Project.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    var container: UserDefaults = .standard

    var wrappedValue: T {
        get {
            return container.object(forKey: key) as? T ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

class CPYUserDefault: NSObject {
    static let shared = CPYUserDefault()
    
    @UserDefault(key: Constants.UserDefaults.storeTypes, defaultValue: [:])
    @objc dynamic var storyType: [String: NSNumber]
    
    @UserDefault(key: Constants.UserDefaults.hotKeys, defaultValue: [:])
    @objc var hotKeys: [String: Any]
    
    @UserDefault(key: Constants.UserDefaults.menuIconSize, defaultValue: false)
    @objc var menuIconSize: Bool
    
    @UserDefault(key: Constants.UserDefaults.maxHistorySize, defaultValue: 0)
    @objc var maxHistorySize: Int

    @UserDefault(key: Constants.UserDefaults.inputPasteCommand, defaultValue: false)
    @objc var inputPasteCommand: Bool

    @UserDefault(key: Constants.UserDefaults.showIconInTheMenu, defaultValue: false)
    @objc var showIconInTheMenu: Bool

    @UserDefault(key: Constants.UserDefaults.numberOfItemsPlaceInline, defaultValue: 0)
    @objc var numberOfItemsPlaceInline: Int

    @UserDefault(key: Constants.UserDefaults.numberOfItemsPlaceInsideFolder, defaultValue: 0)
    @objc var numberOfItemsPlaceInsideFolder: Int

    @UserDefault(key: Constants.UserDefaults.maxMenuItemTitleLength, defaultValue: 0)
    @objc var maxMenuItemTitleLength: Int
    
    @UserDefault(key: Constants.UserDefaults.menuItemsTitleStartWithZero, defaultValue: false)
    @objc var menuItemsTitleStartWithZero: Bool
    
    @UserDefault(key: Constants.UserDefaults.reorderClipsAfterPasting, defaultValue: false)
    @objc var reorderClipsAfterPasting: Bool
    
    @UserDefault(key: Constants.UserDefaults.addClearHistoryMenuItem, defaultValue: false)
    @objc var addClearHistoryMenuItem: Bool

    @UserDefault(key: Constants.UserDefaults.menuItemsAreMarkedWithNumbers, defaultValue: false)
    @objc var menuItemsAreMarkedWithNumbers: Bool
    
    @UserDefault(key: Constants.UserDefaults.showToolTipOnMenuItem, defaultValue: false)
    @objc var showToolTipOnMenuItem: Bool
    
    @UserDefault(key: Constants.UserDefaults.showImageInTheMenu, defaultValue: false)
    @objc var showImageInTheMenu: Bool
    
    @UserDefault(key: Constants.UserDefaults.addNumericKeyEquivalents, defaultValue: false)
    @objc var addNumericKeyEquivalents: Bool
    
    @UserDefault(key: Constants.UserDefaults.maxLengthOfToolTip, defaultValue: 0)
    @objc var maxLengthOfToolTip: Int

    @UserDefault(key: Constants.UserDefaults.loginItem, defaultValue: false)
    @objc var loginItem: Bool

    @UserDefault(key: Constants.UserDefaults.suppressAlertForLoginItem, defaultValue: false)
    @objc var suppressAlertForLoginItem: Bool

    @UserDefault(key: Constants.UserDefaults.showStatusItem, defaultValue: 0)
    @objc var showStatusItem: Int
    
    @UserDefault(key: Constants.UserDefaults.thumbnailWidth, defaultValue: false)
    @objc var thumbnailWidth: Bool
    
    @UserDefault(key: Constants.UserDefaults.thumbnailHeight, defaultValue: false)
    @objc var thumbnailHeight: Bool
    
    @UserDefault(key: Constants.UserDefaults.overwriteSameHistory, defaultValue: false)
    @objc var overwriteSameHistory: Bool
    
    @UserDefault(key: Constants.UserDefaults.copySameHistory, defaultValue: false)
    @objc var copySameHistory: Bool
    
    @UserDefault(key: Constants.UserDefaults.suppressAlertForDeleteSnippet, defaultValue: false)
    @objc var suppressAlertForDeleteSnippet: Bool
    
    @UserDefault(key: Constants.UserDefaults.excludeApplications, defaultValue: false)
    @objc var excludeApplications: Bool
    
    @UserDefault(key: Constants.UserDefaults.collectCrashReport, defaultValue: false)
    @objc var collectCrashReport: Bool
    
    @UserDefault(key: Constants.UserDefaults.showColorPreviewInTheMenu, defaultValue: false)
    @objc var showColorPreviewInTheMenu: Bool

    // beta
    @UserDefault(key: Constants.Beta.observerScreenshot, defaultValue: false)
    @objc var observerScreenshot: Bool
}
