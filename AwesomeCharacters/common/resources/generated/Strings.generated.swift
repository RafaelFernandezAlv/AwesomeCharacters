// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// --
  internal static let empty = L10n.tr("Localizable", "empty")
  /// Sin resultados. Inténtelo de nuevo con otros filtros.
  internal static let noResults = L10n.tr("Localizable", "noResults")
  /// Reintentar
  internal static let retry = L10n.tr("Localizable", "retry")

  internal enum Error {
    /// Ha ocurrido un error. La respuesta de la petición no es correcta
    internal static let invalidResponse = L10n.tr("Localizable", "error.invalidResponse")
    /// Ha ocurrido un error. La respuesta de la petición no es correcta: Status code %d
    internal static func invalidStatusCode(_ p1: Int) -> String {
      return L10n.tr("Localizable", "error.invalidStatusCode", p1)
    }
    /// Ha ocurrido un error. La petición no es correcta
    internal static let invalidURL = L10n.tr("Localizable", "error.invalidURL")
    /// Ha ocurrido un error. Comprube su conexión a internet
    internal static let noInternetConnection = L10n.tr("Localizable", "error.noInternetConnection")
    /// Ha ocurrido un error. Tiempo de espera agotado
    internal static let timeOut = L10n.tr("Localizable", "error.timeOut")
    /// Ha ocurrido un error desconocido
    internal static let unknown = L10n.tr("Localizable", "error.unknown")
  }

  internal enum Link {
    /// Ir a los comics
    internal static let comic = L10n.tr("Localizable", "link.comic")
    /// Ir al detalle
    internal static let detail = L10n.tr("Localizable", "link.detail")
    /// Ir a la wiki
    internal static let wiki = L10n.tr("Localizable", "link.wiki")
  }

  internal enum Search {
    /// Empieza por...
    internal static let placeholder = L10n.tr("Localizable", "search.placeholder")
  }

  internal enum Test {
    /// value
    internal static let key = L10n.tr("Localizable", "test.key")
  }

  internal enum Title {
    /// Apariciones en comics (%d)
    internal static func comic(_ p1: Int) -> String {
      return L10n.tr("Localizable", "title.comic", p1)
    }
    /// Apariciones en eventos (%d)
    internal static func events(_ p1: Int) -> String {
      return L10n.tr("Localizable", "title.events", p1)
    }
    /// Enlaces
    internal static let links = L10n.tr("Localizable", "title.links")
    /// Listado
    internal static let list = L10n.tr("Localizable", "title.list")
    /// Apariciones en series (%d)
    internal static func series(_ p1: Int) -> String {
      return L10n.tr("Localizable", "title.series", p1)
    }
    /// Apariciones en historias (%d)
    internal static func stories(_ p1: Int) -> String {
      return L10n.tr("Localizable", "title.stories", p1)
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
