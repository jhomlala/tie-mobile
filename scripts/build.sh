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

echo '-------------------------------'
echo 'Usecase- pub get'
echo '-------------------------------'
(cd packages/usecase && flutter pub get)

echo '-------------------------------'
echo 'Game - pub get'
echo '-------------------------------'
(cd packages/game && flutter pub get)

echo '-------------------------------'
echo 'UI - pub get'
echo '-------------------------------'
(cd packages/ui && flutter pub get)

sh ./scripts/build_models.sh