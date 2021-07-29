//
// Wire
// Copyright (C) 2021 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//


import Foundation
import UniformTypeIdentifiers
import CoreServices

@objc
public final class UTIHelper: NSObject {
    
    @objc
    public class func conformsToVectorType(mimeType: String) -> Bool {
        if #available(iOS 14, *) {
            guard let utType = UniformTypeIdentifiers.UTType(mimeType: mimeType) else {
                return false
            }

            return utType.conforms(to: UniformTypeIdentifiers.UTType.svg)
        } else {
            return UTTypeConformsTo(mimeType as CFString, kUTTypeScalableVectorGraphics)
        }
    }

    
    @objc
    public class func convertToMime(uti: String) -> String? {
        
        let mimeType: String
        if #available(iOS 14, *) {
            guard let utType = UniformTypeIdentifiers.UTType(uti) else {
                return nil
            }

            if let preferredMIMEType = utType.preferredMIMEType {
                mimeType = preferredMIMEType
            } else {
                #if targetEnvironment(simulator)
                ///HACK: hard code MIME when preferredMIMEType is nil for M1 simulator, we should file a ticket to apple for this issue
                switch utType {
                case .jpeg:
                    mimeType = "image/jpeg"
                case .png:
                    mimeType = "image/png"
                case .gif:
                    mimeType = "image/gif"
                case .json:
                    mimeType = "application/json"
                default:
                    return nil
                }
                #else
                return nil
                #endif
            }

        } else {
            let unmanagedMime = UTTypeCopyPreferredTagWithClass(uti as CFString, kUTTagClassMIMEType)
            
            guard let retainedValue = unmanagedMime?.takeRetainedValue() else {
                return nil
            }

            mimeType = retainedValue as String
        }

        return mimeType
    }

}
