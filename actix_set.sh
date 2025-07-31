#!/bin/bash

# Path to your Actix API folder
ACTIX_DIR="$HOME/rust/actixApi"

echo "🔁 Starting to cache all Actix API projects in $ACTIX_DIR"
echo "-----------------------------------------------------------"

# Loop through each subproject in actixApi
for project in "$ACTIX_DIR"/*; do
    if [ -f "$project/Cargo.toml" ]; then
        echo "📦 Caching: $(basename "$project")"
        cd "$project" || continue
        cargo fetch
        cargo build
        echo "✅ Done: $(basename "$project")"
        echo "-------------------------------"
    fi
done

echo "🎯 All Actix APIs are cached and compiled!"
