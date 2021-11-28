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
    /// Ha ocurrido un error desconocido
    internal static let unknown = L10n.tr("Localizable", "error.unknown")
  }

  internal enum Test {
    /// value
    internal static let key = L10n.tr("Localizable", "test.key")
  }

  internal enum Title {
    /// Listado
    internal static let list = L10n.tr("Localizable", "title.list")
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
