// swift-tools-version: 5.5

import PackageDescription

let package = Package(
	name: "BitcoinQRCode",
	platforms: [
		.macOS(.v10_13),
		.iOS(.v11),
		.tvOS(.v13),
		.watchOS(.v6)
	],
	products: [
		.library(name: "BitcoinQRCode", targets: ["BitcoinQRCode"]),
		.library(name: "BitcoinQRCodeStatic", type: .static, targets: ["BitcoinQRCode"]),
		.library(name: "BitcoinQRCodeDynamic", type: .dynamic, targets: ["BitcoinQRCode"]),
		.library(name: "BitcoinQRCodeDetector", type: .dynamic, targets: ["QRCodeDetector"]),
	],
	dependencies: [
		.package(
			name: "swift-argument-parser",
			url: "https://github.com/apple/swift-argument-parser",
			.upToNextMinor(from: "0.4.3")
		),
		.package(
			url: "https://github.com/bitcoin-portal/SwiftQRCodeGenerator",
			from: "2.0.4"
		),
		.package(
			url: "https://github.com/bitcoin-portal/SwiftImageReadWriteKit",
			from: "1.9.3"
		),
	],
	targets: [
		.target(
			name: "BitcoinQRCode",
			dependencies: [
				.product(name: "SwiftImageReadWriteKit", package: "SwiftImageReadWriteKit"),
				.product(name: "BitcoinQRCodeGenerator", package: "SwiftQRCodeGenerator"),
			],
			path: "Sources/QRCode",
			resources: [
				.copy("PrivacyInfo.xcprivacy"),
			]
		),
		.target(
			name: "QRCodeDetector",
			resources: [
				.copy("PrivacyInfo.xcprivacy"),
			]
		),
		.executableTarget(
			name: "qrcodegen",
			dependencies: [
				"BitcoinQRCode",
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
			],
			resources: [
				.copy("PrivacyInfo.xcprivacy"),
			]
		),
		.testTarget(
			name: "QRCodeTests",
			dependencies: ["BitcoinQRCode"],
			resources: [
				.process("Resources"),
			]
		),
	]
)
