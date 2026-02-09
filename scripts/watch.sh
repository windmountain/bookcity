#!/usr/bin/env bash
open index.html
find src -name '*.elm' | entr -r npm run build
