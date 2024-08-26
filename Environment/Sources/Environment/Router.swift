import Models
import Observation
import SwiftUI


public enum RouterDestination: Hashable {
    case assetDetails(url: String)
}


public enum SheetDestination: Identifiable {
    case example
    
    public var id: String {
        switch self {
        case .example:
            "example"
        }
    }
}


@MainActor @Observable
public class RouterPath {
    
    // MARK: Public properties
    
    public var path: [RouterDestination] = []
    public var presentedSheet: SheetDestination?
    
    
    // MARK: Lifecyce
    
    public init() { }
    
    
    // MARK: Public methods
    
    public func navigate(to destination: RouterDestination) {
        path.append(destination)
    }
}

