# TATLayout CHANGELOG

## 1.0.1

Some updates.

- Fixed documentation link in the README.
- Removed warnings in the deprecated methods test file.

## 1.0.0

TATLayout is mature enough for version 1!

- Implemented active/isActive property relying in iOS 8 when available.
- Deprecated TATInstallation category but still providing the category for backwards compatibility.
- Updated unit tests
- Updated example app

## 0.3.2

Attempt to fix documentation generation.

- Updated README

## 0.3.1

Attempt to fix documentation generation.

- Updated README

## 0.3.0

Constraint Installation implementation.

- Implemented NSLayoutConstraint+TATInstallation category.
- Simplified example app: keeping one only view controller containing code examples of almost all APIs.
- Removed local documentation target (CocoaDocs is awesome so we don't need to create the documentation manually)

## 0.2.0

View constraints implementation.

- Implemented UIView+TATViewConstraints category.
- Extended Examples app with View Constraints example.
- Renamed categories for consistency.
- Specs covering TATViewConstraints and private classes functionality.

## 0.1.1

Improvements in the documentation, project restructure.

- Moved installation steps to the Wiki.
- Restructured project files for simplicity.
- Reduced the repository size for faster downloads by removing launch images in the examples app.

## 0.1.0

Initial release.

- Implemented NSLayoutConstraint+TATLayoutFactory category.
- Created Xcode target to build the documentation locally.
- Created Xcode target to build the universal architecture library.
- Created Examples app with Factory example.
- Specs covering TATLayoutFactory functionality and diagnostic error messages.
