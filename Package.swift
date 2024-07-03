// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftGosu",
  platforms: [
    .macOS(.v14)
  ],
  targets: [
    .executableTarget(
      name: "SwiftGosu",
      dependencies: ["CGosuFFI"],
      path: "Sources",
      exclude: ["CGosuFFI"],
      swiftSettings: [.interoperabilityMode(.Cxx)],
      linkerSettings: [.linkedLibrary("gosu")]
    ),
    .systemLibrary(
      name: "CGosuFFI",
      providers: [.brew(["libgosu"])]
    ),
  ]
)
