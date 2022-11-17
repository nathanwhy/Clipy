//
//  DataCleanService.swift
//
//  Clipy
//  GitHub: https://github.com/clipy
//  HP: https://clipy-app.com
//
//  Created by Econa77 on 2016/11/20.
//
//  Copyright © 2015-2018 Clipy Project.
//

import Foundation
import RealmSwift
import PINCache
import Combine

final class DataCleanService {

    // MARK: - Properties
    private var queue = DispatchQueue(label: "clean-data", qos: .utility)
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Monitoring
    func startMonitoring() {
        // Clean datas every 30 minutes
        Timer.publish(every: 1800, on: .current, in: .default)
            .autoconnect()
            .subscribe(on: queue)
            .sink { [weak self] _ in
                self?.cleanDatas()
            }.store(in: &subscriptions)
    }

    // MARK: - Delete Data
    func cleanDatas() {
        let realm = try! Realm()
        let flowHistories = overflowingClips(with: realm)
        flowHistories
            .filter { !$0.isInvalidated && !$0.thumbnailPath.isEmpty }
            .map { $0.thumbnailPath }
            .forEach { PINCache.shared.removeObject(forKey: $0) }
        realm.transaction { realm.delete(flowHistories) }
        cleanFiles(with: realm)
    }

    private func overflowingClips(with realm: Realm) -> Results<CPYClip> {
        let clips = realm.objects(CPYClip.self).sorted(byKeyPath: #keyPath(CPYClip.updateTime), ascending: false)
        let maxHistorySize = AppEnvironment.current.defaults.integer(forKey: Constants.UserDefaults.maxHistorySize)

        if clips.count <= maxHistorySize { return realm.objects(CPYClip.self).filter("FALSEPREDICATE") }
        // Delete first clip
        let lastClip = clips[maxHistorySize - 1]
        if lastClip.isInvalidated { return realm.objects(CPYClip.self).filter("FALSEPREDICATE") }

        // Deletion target
        let updateTime = lastClip.updateTime
        let targetClips = realm.objects(CPYClip.self).filter("updateTime < %d", updateTime)

        return targetClips
    }

    private func cleanFiles(with realm: Realm) {
        let fileManager = FileManager.default
        guard let paths = try? fileManager.contentsOfDirectory(atPath: CPYUtilities.applicationSupportFolder()) else { return }

        let allClipPaths = Array(realm.objects(CPYClip.self)
            .filter { !$0.isInvalidated }
            .compactMap { $0.dataPath.components(separatedBy: "/").last })

        // Delete diff datas
        DispatchQueue.main.async {
            Set(allClipPaths).symmetricDifference(paths)
                .map { CPYUtilities.applicationSupportFolder() + "/" + "\($0)" }
                .forEach { CPYUtilities.deleteData(at: $0) }
        }
    }
}
