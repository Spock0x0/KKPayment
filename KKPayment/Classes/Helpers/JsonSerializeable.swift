//
//  JsonSerializeable.swift
//  KKPayment
//
//  Created by Spock on 2022/8/31.
//

/// 暫時性
import Foundation

public typealias JsonDictionary = [String: Any]

public protocol PropertyMapping {
    /**
     * (propertyName, JsonName)
     */
    func propertyMapping() -> [(String?, String?)]
}

#if DEBUG
extension PropertyMapping {
    public func testSwiftProperty(mirrorChildren: AnyCollection<Mirror.Child>) {
        
        let mappings = propertyMapping()
        
        for (swiftName, _) in mappings {

            let isContains: Bool = mirrorChildren.contains(where: { (label, _) -> Bool in
                return swiftName == label
            })
            
            if !isContains {

                let swiftName: String = swiftName ?? ""
                let errorMessage: String = "Swift name \"\(swiftName)\" is not correct in property mapping"
                print(errorMessage)

                assert(false)
            }
        }
    }
}
#endif

public protocol PropertyConverters {
    func propertyConverters() -> [(String?, () -> Any?)]
}

#if DEBUG
extension PropertyConverters {
    public func testSwiftProperty(mirrorChildren: AnyCollection<Mirror.Child>) {
        
        let mappings = propertyConverters()
        
        for (swiftName, _) in mappings {
            
            let isContains: Bool = mirrorChildren.contains(where: { (label, _) -> Bool in
                return swiftName == label
            })
            
            if !isContains {
                
                let swiftName: String = swiftName ?? ""
                let errorMessage: String = "Swift name \"\(swiftName)\" is not correct in property converters"
                print(errorMessage)
                
                assert(false)
            }
        }
    }
}
#endif

public struct Utilities {
    public static func unwrap(_ subject: Any) -> Any? {

        var value: Any?
        let mirrored = Mirror(reflecting: subject)

        if mirrored.displayStyle != .optional {
            value = subject
        } else if let firstChild = mirrored.children.first {
            value = firstChild.value
        }

        return value
    }
}

public protocol ArrayType {
    var arrayGenericType: Any { get }
    func getJsonSerializableArray() -> [JsonSerializeable]?

    func toJsonArray() -> Array<Any>
    func toJsonData(_ options: JSONSerialization.WritingOptions) -> Data?
    func toJsonString(_ options: JSONSerialization.WritingOptions) -> String
}

public protocol JsonSerializeable {

    func toDictionary() -> JsonDictionary
    func toJsonData(_ options: JSONSerialization.WritingOptions) -> Data?
    func toJsonString(_ options: JSONSerialization.WritingOptions) -> String
}

extension JsonSerializeable {
    public func toDictionary() -> JsonDictionary {
        var dictionary: Dictionary<String, Any> = Dictionary<String, Any>()
        let mirror: Mirror = Mirror(reflecting: self)

        let converter: PropertyConverters? = self as? PropertyConverters
        var propertyConverters: [(String?, () -> Any?)] = []
        if let converter = converter {
            propertyConverters = converter.propertyConverters()
        }

        let propertyMapper: PropertyMapping? = self as? PropertyMapping
        var propertyMappings: [(String?, String?)] = []
        if let propertyMapper = propertyMapper {
            propertyMappings = propertyMapper.propertyMapping()
        }

        let mirrorChildren: AnyCollection<Mirror.Child>

        // Enum type
        if mirror.children.isEmpty {

            let label: String = "\(self)"
            let value: String = "\(self)"
            let children: [Mirror.Child] = [
                (label: label, value: value)
            ]

            mirrorChildren = AnyCollection<Mirror.Child>(children)

        } else {
            mirrorChildren = mirror.children
        }

        #if DEBUG
            propertyMapper?.testSwiftProperty(mirrorChildren: mirrorChildren)
            converter?.testSwiftProperty(mirrorChildren: mirrorChildren)
        #endif

        for (label, value) in mirrorChildren {

            guard let propertyName: String = label else {
                continue
            }

            // PropertyMapping, PropertyConverter
            guard let outputKey: String = getOutputKey(propertyName, propertyMappings: &propertyMappings) else {
                continue
            }

            let value: Any? = Utilities.unwrap(value)

            guard let outputValue: Any = getOutputValue(propertyName, value: value, converters: &propertyConverters) else {
                continue
            }

            switch outputValue {
            case is String,
                 is Bool,
                 is Int,
                 is UInt,
                 is Double,
                 is CGFloat,
                 is Decimal:
                dictionary[outputKey] = outputValue

            case let array as ArrayType:
                dictionary[outputKey] = array.toJsonArray()

            case let jsonSerializeable as JsonSerializeable:
                dictionary[outputKey] = jsonSerializeable.toDictionary()

            case let jsonDictionary as JsonDictionary:
                dictionary[outputKey] = jsonDictionary

            default:
                assert(false)
                break
            }

        }

        return dictionary
    }

    public func toJsonData(_ options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions()) -> Data? {
        let dictionary: JsonDictionary = toDictionary()

        let data: Data? = try? JSONSerialization.data(withJSONObject: dictionary, options: options)
        return data
    }

    public func toJsonString(_ options: JSONSerialization.WritingOptions = JSONSerialization.WritingOptions()) -> String {
        guard let data: Data = toJsonData(options) else {
            return "{}"
        }

        return String(data: data, encoding: String.Encoding.utf8) ?? "{}"
    }

    /**
     取得QueryString的 Key
     
     - parameter propertyName:     屬性名稱
     - parameter propertyMappings: propertyMappings description
     
     - returns: 轉換後的Key
     */
    func getOutputKey(_ propertyName: String, propertyMappings: inout [(String?, String?)]) -> String? {
        var outputKey: String? = propertyName

        // 尋找該屬性是否有使用 propertyMapping
        let propertyMappingIndexWrapped: Int? = propertyMappings.firstIndex(where: { (parameter: (String?, String?)) -> Bool in
            return parameter.0 == propertyName
        })

        guard let propertyMappingIndex: Int = propertyMappingIndexWrapped else {
            return propertyName
        }

        outputKey = propertyMappings[propertyMappingIndex].1
        propertyMappings.remove(at: propertyMappingIndex)

        return outputKey
    }

    /**
     取得QueryString的Value
     
     - parameter propertyName: 屬性名稱
     - parameter value:        屬性值
     - parameter converters:   converters description
     
     - returns: 轉換後的Value
     */
    func getOutputValue(_ propertyName: String, value: Any?, converters: inout [(String?, () -> Any?)]) -> Any? {
        // 尋找該屬性是否有使用 propertyConverter
        let indexWrapped: Int? = converters.firstIndex(where: { (parameter: (String?, () -> Any?)) -> Bool in
            return propertyName == parameter.0
        })

        // 該屬性是使用 propertyConverter
        guard let index: Int = indexWrapped else {
            return value
        }

        let converter: (String?, () -> Any?) = converters[index]

        // 移除已Match的
        converters.remove(at: index)

        // 回傳轉換後的Value
        return converter.1()
    }
}
