import DesignSystems
import Environment
import Models
import SwiftUI


@MainActor
public struct HomeListRowView: View {
    
    // MARK: Environment
    
    @Environment(RouterPath.self) var routerPath
    @Environment(Theme.self) var theme
    
    
    // MARK: Public properties
    
    @Bindable public var asset: LearningAsset
    
    
    // MARK: Body
    
    public var body: some View {
        HStack(spacing: .medium) {
            thumbnail
            
            VStack(alignment: .leading) {
                assetTitle
                
                if !asset.tags.isEmpty {
                    Spacer()
                    
                    tags
                }
            }
            
            Spacer()
            
            typeIcon
        }
        .padding(.medium)
        .background(theme.secondaryBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: .regular))
        .onTapGesture {
            routerPath.navigate(to: .assetDetails(asset: asset))
        }
    }
    
    
    // MARK: Lifecycle
    
    public init(asset: LearningAsset) {
        self.asset = asset
    }
    
    
    // MARK: Subviews
    
    private var thumbnail: some View {
        AssetThumbnailView(
            urlString: asset.imageUrl,
            cornerRadius: .small,
            size: .xxLarge
        )
    }
    
    private var assetTitle: some View {
        Text(asset.title)
            .font(.scaledBody)
            .foregroundStyle(theme.labelColor)
    }
    
    private var tags: some View {
        HStack(spacing: .xSmall) {
            ForEach(asset.tags, id: \.self) {
                TagView(tag: $0)
            }
        }
    }
    
    private var typeIcon: some View {
        AssetTypeIconView(assetType: asset.type)
    }
}
