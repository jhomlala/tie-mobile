#!/bin/bash
echo '-------------------------------'
echo 'App - pub get'
echo '-------------------------------'
flutter pub get

echo '-------------------------------'
echo 'Domain - pub get'
echo '-------------------------------'
(cd packages/domain && flutter pub get)

echo '-------------------------------'
echo 'Data - pub get'
echo '-------------------------------'
(cd packages/data && flutter pub get)


sh ./scripts/build_models.sh