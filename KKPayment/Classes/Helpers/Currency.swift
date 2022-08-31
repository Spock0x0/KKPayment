//
//  Currency.swift
//  KKPayment
//
//  Created by Spock on 2022/8/31.
//

public enum Currency: String {
    case chf = "CHF"
    case fjd = "FJD"
    case mxn = "MXN"
    case ars = "ARS"
    case qar = "QAR"
    case kzt = "KZT"
    case sar = "SAR"
    case inr = "INR"
    case vnd = "VND"
    case xpf = "XPF"
    case thb = "THB"
    case cny = "CNY"
    case aud = "AUD"
    case krw = "KRW"
    case ils = "ILS"
    case jpy = "JPY"
    case pln = "PLN"
    case gbp = "GBP"
    case idr = "IDR"
    case huf = "HUF"
    case php = "PHP"
    case kwd = "KWD"
    case `try` = "TRY"
    case rub = "RUB"
    case jod = "JOD"
    case isk = "ISK"
    case twd = "TWD"
    case hkd = "HKD"
    case aed = "AED"
    case eur = "EUR"
    case dkk = "DKK"
    case cad = "CAD"
    case usd = "USD"
    case myr = "MYR"
    case bgn = "BGN"
    case nok = "NOK"
    case ron = "RON"
    case sgd = "SGD"
    case ngn = "NGN"
    case omr = "OMR"
    case czk = "CZK"
    case pkr = "PKR"
    case pen = "PEN"
    case sek = "SEK"
    case nzd = "NZD"
    case brl = "BRL"
    case uah = "UAH"
    case bhd = "BHD"
    case bif = "BIF"
    case xaf = "XAF"
    case clp = "CLP"
    case kmf = "KMF"
    case djf = "DJF"
    case gnf = "GNF"
    case mga = "MGA"
    case pyg = "PYG"
    case rwf = "RWF"
    case vuv = "VUV"
    case xof = "XOF"

    public var symbol: String {

        switch self {
        case .aud, .cad, .hkd, .nzd, .sgd, .twd, .usd:
            return "$"
        case .cny, .jpy:
            return "¥"
        case .eur:
            return "€"
        case .gbp:
            return "£"
        case .idr:
            return "Rp"
        case .krw:
            return "￦"
        case .myr:
            return "RM"
        case .php:
            return "₱"
        case .thb:
            return "฿"
        case .vnd:
            return "₫"
        default:
            return systemSymbol
        }
    }

    private var systemSymbol: String {
        let identifier: String = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: self.rawValue])
        let locale: Locale = NSLocale(localeIdentifier: identifier) as Locale

        return locale.currencySymbol ?? self.rawValue
    }
}

extension Currency: Codable { }
