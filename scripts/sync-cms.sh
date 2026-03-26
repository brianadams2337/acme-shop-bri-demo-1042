#!/bin/bash

# Script to sync CMS content and generate types based on CMS_PROVIDER environment variable
# Usage: ./scripts/sync-cms.sh
# Requires CMS_PROVIDER environment variable to be set to either 'storyblok' or 'contentful'

set -e

# Load environment variables from .env file if it exists
# This approach safely handles:
# - Empty lines
# - Comment lines (lines starting with #)
# - Inline comments (e.g., KEY=value # comment)
# - Values with quotes (e.g., KEY='value' or KEY="value")
# - Values with special characters or spaces
if [ -f ".env" ]; then
    echo "📄 Loading environment variables from .env file..."
    while IFS= read -r line || [ -n "$line" ]; do
        # Skip empty lines and comment-only lines
        [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

        # Remove inline comments (everything after # on the line)
        line=$(echo "$line" | sed 's/#.*$//')

        # Remove surrounding quotes from values (both single and double quotes)
        # Pattern 1: Remove quotes after = sign (handles KEY='value' -> KEY=value)
        # Pattern 2: Remove trailing quotes and whitespace
        line=$(echo "$line" | sed "s/=\s*['\"]*/=/;s/['\"]* *$//")

        # Export the cleaned variable
        export "$line"
    done < .env
fi

if [ -z "$CMS_PROVIDER" ]; then
    echo "Error: CMS_PROVIDER environment variable is not set"
    echo "Please set CMS_PROVIDER to either 'storyblok' or 'contentful'"
    exit 1
fi

case "$CMS_PROVIDER" in
    "storyblok")
        echo "🚀 Syncing Storyblok content and generating types..."

        REQUIRED_STORYBLOK_VARS=("STORYBLOK_PERSONAL_TOKEN" "NUXT_PUBLIC_CMS_SPACE")

        for VAR in "${REQUIRED_STORYBLOK_VARS[@]}"; do
            if ! grep -q "^$VAR=" ".env"; then
                echo "❌ Error: Required variable '$VAR' not found in .env"
                exit 1
            fi
        done

        # Login to Storyblok
        echo "📝 Logging into Storyblok..."
        pnpm exec storyblok login --token $STORYBLOK_PERSONAL_TOKEN --region eu

        # Pull components from Storyblok
        echo "📥 Pulling components from Storyblok..."
        pnpm exec storyblok components pull --space $NUXT_PUBLIC_CMS_SPACE

        # Generate TypeScript types and organize them
        echo "🔧 Generating TypeScript types..."
        pnpm exec storyblok ts generate --space $NUXT_PUBLIC_CMS_SPACE
        rm -rf modules/cms/providers/storyblok/types/gen/components
        cp -r .storyblok/types/* modules/cms/providers/storyblok/types/gen/
        mv modules/cms/providers/storyblok/types/gen/$NUXT_PUBLIC_CMS_SPACE modules/cms/providers/storyblok/types/gen/components

        echo "✅ Storyblok sync completed successfully!"
        ;;

    "contentful")
        echo "🚀 Syncing Contentful content and generating types..."

        REQUIRED_CONTENTFUL_VARS=("NUXT_PUBLIC_CMS_SPACE" "CONTENTFUL_MANAGEMENT_TOKEN")

        # Check that all required variables are present in the .env.contentful file
        for VAR in "${REQUIRED_CONTENTFUL_VARS[@]}"; do
            if ! grep -q "^$VAR=" ".env"; then
                echo "❌ Error: Required variable '$VAR' not found in .env"
                exit 1
            fi
        done

        # Export content from Contentful
        echo "📥 Exporting content from Contentful..."
        pnpm exec contentful space export --space-id $NUXT_PUBLIC_CMS_SPACE --management-token $CONTENTFUL_MANAGEMENT_TOKEN  --skip-webhooks --skip-roles --skip-content --content-file contentful.$NUXT_PUBLIC_CMS_SPACE.json

        # Generate TypeScript types
        echo "🔧 Generating TypeScript types..."
        pnpm exec cf-content-types-generator -X --response --typeguard ./contentful.$NUXT_PUBLIC_CMS_SPACE.json --out ./modules/cms/providers/contentful/types/gen
        find ./modules/cms/providers/contentful/types/gen -type f -name '*.ts' -print0 | xargs -0 sed -i '' -E "s/Type([[:alnum:]]+)<'WITHOUT_(LINK_RESOLUTION|UNRESOLVABLE_LINKS)'>/Type\\1<'WITHOUT_\\2', LocaleCode>/g"

        echo "✅ Contentful sync completed successfully!"
        ;;
    "contentstack")
        echo "🚀 Syncing Contentstack content and generating types..."

        REQUIRED_CONTENTSTACK_VARS=("NUXT_PUBLIC_CMS_REGION" "NUXT_PUBLIC_CMS_ACCESS_TOKEN" "NUXT_PUBLIC_CMS_DELIVERY_ACCESS_TOKEN" "NUXT_PUBLIC_CMS_ENVIRONMENT")

        # Check that all required variables are present in the .env.contentful file
        for VAR in "${REQUIRED_CONTENTSTACK_VARS[@]}"; do
            if ! grep -q "^$VAR=" ".env"; then
                echo "❌ Error: Required variable '$VAR' not found in .env"
                exit 1
            fi
        done
        # installing ts generation plugin
        pnpm exec csdx plugins:install contentstack-cli-tsgen
        # setting region
        pnpm exec csdx config:set:region $NUXT_PUBLIC_CMS_REGION
        # adding delivery token
        pnpm exec csdx auth:tokens:add --delivery -a sync-token -k $NUXT_PUBLIC_CMS_ACCESS_TOKEN --token $NUXT_PUBLIC_CMS_DELIVERY_ACCESS_TOKEN -y -e $NUXT_PUBLIC_CMS_ENVIRONMENT
        # generating types
        if [ -n "$NUXT_PUBLIC_CMS_BRANCH" ]; then
          pnpm exec csdx tsgen -a sync-token --branch $NUXT_PUBLIC_CMS_BRANCH -o "modules/cms/providers/contentstack/types/gen/contentstack.d.ts" --include-system-fields
        else
          pnpm exec csdx tsgen -a sync-token -o "modules/cms/providers/contentstack/types/gen/contentstack.d.ts" --include-system-fields
        fi

        echo "✅ Contentstack sync completed successfully!"

        ;;
    *)
        echo "ℹ️  No sync steps defined for CMS_PROVIDER value '$CMS_PROVIDER'. Nothing to sync."
        ;;
esac

echo "🎉 CMS sync process completed!"
