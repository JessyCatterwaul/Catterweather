#!/bin/sh

originalBranch=$(git branch --show-current)

git branch github-pages
git checkout github-pages

xcrun xcodebuild docbuild \
  -scheme Catterweather \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath "$PWD/.derivedData"

xcrun docc process-archive transform-for-static-hosting \
  "$PWD/.derivedData/Build/Products/Debug-iphonesimulator/Catterweather.doccarchive" \
  --hosting-base-path Catterweather \
  --output-path ./docs

git add --all
git commit -m "Generate documentation for GitHub Pages"
git push Public github-pages --force

git checkout $originalBranch
git branch -D github-pages
