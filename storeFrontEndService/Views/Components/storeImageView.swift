import SwiftUI

/// A View that loads an image from a URL string,
/// showing built-in placeholder, progress indicator, and failure UI.
struct URLImageView: View {
    private let url: URL?

    /// Initialize with any image URL.
    init(_ urlString: String) {
        self.url = URL(string: urlString)
    }

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {

            case .empty:
                // 🚀 Request sent but no image yet
                placeholderView()

            case .success(let image):
                // ✅ Got the image: make it resizable for caller to size
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)

            case .failure:
                // ⚠ Something went wrong: show fallback UI
                failureView()

            @unknown default:
                // 🛡 Future cases: treat like “empty”
                placeholderView()
            }
        }
    }

    // MARK: - Internal Subviews

    /// View shown while the image is first loading.
    @ViewBuilder
    private func placeholderView() -> some View {
        VStack {
            ProgressView()
            Text("Loading image…")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    /// View shown if loading fails.
    @ViewBuilder
    private func failureView() -> some View {
        VStack {
            Image(systemName: "photo.fill")
                .font(.largeTitle)
                .padding(.bottom, 4)
            Text("Image unavailable")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
