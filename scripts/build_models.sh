#!/bin/bash
echo '-------------------------------'
echo 'App - building models'
echo '-------------------------------'
dart run build_runner build --delete-conflicting-outputs

echo '-------------------------------'
echo 'Domain - building models'
echo '-------------------------------'
(cd packages/domain && dart run build_runner build --delete-conflicting-outputs)
