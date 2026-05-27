// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "NALA-DNA-Med",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(name: "NALADNAMedCore", targets: ["NALADNAMedCore"]),
        .executable(name: "NALA-DNA-Med", targets: ["NALADNAMedApp"])
    ],
    targets: [
        .target(name: "NALADNAMedCore"),
        .executableTarget(
            name: "NALADNAMedApp",
            dependencies: ["NALADNAMedCore"],
            path: "Sources/NALADNAMedApp"
        ),
        .testTarget(
            name: "NALADNAMedCoreTests",
            dependencies: ["NALADNAMedCore"]
        )
    ]
)
