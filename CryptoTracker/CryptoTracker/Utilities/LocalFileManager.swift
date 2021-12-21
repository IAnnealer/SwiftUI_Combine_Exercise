//
//  LocalFileManager.swift
//  CryptoTracker
//
//  Created by Ian on 2021/12/21.
//

import Foundation
import SwiftUI

final class LocalFileManager {

    // MARK: - Properties

    private enum FileIOError: LocalizedError {
        case cantFindURL
        case writeError
        case cantCreateDirectory

        var errorDescription: String? {
            switch self {
            case .cantFindURL:
                return "[⚠️ ERROR - \(#file)] Cant Find URL"
            case .writeError:
                return "[⚠️ ERROR - \(#file)] Write Error"
            case .cantCreateDirectory:
                return "[⚠️ ERROR - \(#file)] Cant Create Directory"
            }
        }
    }

    static let instance = LocalFileManager()

    // MARK: - Initializer

    private init() { }

    // MARK: - Methods

    func saveIamge(_ image: UIImage, imageName: String, folderName: String) {
        createFolderIfNeeded(folderName: folderName)
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName) else {
                  return
              }

        do {
            try data.write(to: url)
        } catch {
            print("\(FileIOError.writeError.localizedDescription) - \(error.localizedDescription)")
        }
    }

    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
                  return nil
              }

        return UIImage(contentsOfFile: url.path)
    }
}

// MARK: - Private Extension

private extension LocalFileManager {
    func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            print("\(FileIOError.cantFindURL.localizedDescription)")
            return nil
        }

        return url.appendingPathComponent(folderName)
    }

    func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }

        return folderURL.appendingPathComponent(imageName + ".png")
    }

    func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else {
            return
        }

        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            } catch {
                print("\(FileIOError.cantCreateDirectory.localizedDescription) - \(error.localizedDescription)")
            }
        }
    }
}
