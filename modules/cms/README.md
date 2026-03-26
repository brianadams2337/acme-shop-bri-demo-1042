# CMS module

## Setup

To set up the CMS integration, run the setup command:

```bash
pnpx @scayle/storefront-cli setup cms
```

After the initial setup, you can sync the CMS types by running:

```bash
pnpm cms:sync
```

This command will generate and update the TypeScript types for your CMS content models,
ensuring type safety throughout your application.

---

## Storyblok - Overview

The Storefront Application integrates with [Storyblok](https://www.storyblok.com/),
a headless CMS that provides a Visual Editor for content management.
This integration allows you to manage CMS content for your storefront,
including content pages, category page enhancements, and custom components.

### What is Storyblok?

Storyblok is a headless CMS with a visual editor that combines the flexibility of
a headless CMS with the ease of use of traditional CMSs.
Key features include:

- **Visual Editor**: Real-time preview and editing of content
- **Component-based**: Build reusable content blocks
- **Multi-language support**: Manage content in multiple languages
- **API-first**: Fast, CDN-cached content delivery
- **Developer-friendly**: Component SDK and extensive documentation

### Key Features

- **Automatic internationalization**: Folder-based i18n with automatic slug resolution
- **Visual Editor support**: Live preview with hot-reload during content editing
- **Component mapping**: Automatic Vue component resolution from Storyblok components
- **Flexible routing**: Works with path-based, domain-based, and path-except-default routing modes
- **Type-safe**: Full TypeScript support with generated types
- **Error handling**: Graceful 404 handling for missing content
- **Caching**: Built-in response caching for optimal performance

### When to Use?

Use the Storyblok integration when you need:

- **Content pages**: About, Privacy Policy, Terms of Service, Help pages
- **Category enhancements**: Additional content blocks on Product Listing Pages
- **Homepage content**: Dynamic hero banners, promotional sections, featured products
- **Marketing content**: Campaign pages, landing pages, seasonal content
- **Editorial content**: Blog posts, news articles, style guides

### Technical Details

For technical details how the Storyblok integrations works within the Storefront Application,
check the dedicated [Storyblok integration documentation](./providers/storyblok/STORYBLOK.md).

---

## Contentful - Overview

The Storefront Application integrates with [Contentful](https://www.contentful.com/),
a headless CMS that provides flexible content management with a powerful API.
This integration allows you to manage CMS content for your storefront,
including content pages, category page enhancements, and custom components.

### What is Contentful?

Contentful is a headless CMS with an API-first approach that provides flexible content modeling and delivery.
Key features include:

- **Live Preview**: Real-time content editing with instant preview updates.
- **Content modeling**: Flexible content types with custom fields and relationships.
- **Multi-language support**: Native locale system with configurable fallback chains.
- **API-first**: Fast, CDN-cached content delivery via REST and GraphQL APIs.
- **Type generation**: Automatic TypeScript type generation from content models.

### Key Features

- **Live Preview support**: Real-time content editing with instant preview updates.
- **Type-safe integration**: Automatic TypeScript type generation from Contentful content models.
- **Locale support**: Native multi-language content with configurable fallback chains.
- **Component-based architecture**: Reusable content blocks mapped to Vue components.
- **Automatic caching**: Built-in response caching for optimal performance.
- **Error handling**: Graceful fallback for missing content and unconfigured locales.

### When to Use?

Use the Contentful integration when you need:

- **Content pages**: About, Privacy Policy, Terms of Service, Help pages.
- **Category enhancements**: Additional content blocks on Product Listing Pages.
- **Homepage content**: Dynamic hero banners, promotional sections, featured products.
- **Marketing content**: Campaign pages, landing pages, seasonal content.
- **Editorial content**: Blog posts, news articles, style guides.

### Technical Details

For technical details how the Contentful integration works within the Storefront Application,
check the dedicated [Contentful integration documentation](./providers/contentful/CONTENTFUL.md).

---

## Contentstack - Overview

The Storefront Application integrates with [Contentstack](https://www.contentstack.com/),
a headless CMS that provides flexible content management with a powerful API.
This integration allows you to manage CMS content for your storefront,
including content pages, category page enhancements, and custom components.

### Key Features

- **Live Preview**: Real-time content editing with instant preview updates.
- **Type-safe integration**: Automatic TypeScript type generation from Contentstack content models.
- **Locale support**: Native multi-language content with configurable fallback chains.
- **Component-based architecture**: Reusable content blocks mapped to Vue components.
- **Automatic caching**: Built-in response caching for optimal performance.
- **Regional support**: Multi-region deployment with automatic endpoint resolution.

### When to Use Contentstack

Use the Contentstack integration for:

- **Content pages**: About, Privacy Policy, Terms of Service, Help pages.
- **Category enhancements**: Additional content blocks on Product Listing Pages.
- **Homepage content**: Dynamic hero banners, promotional sections, featured products.
- **Marketing content**: Campaign pages, landing pages, seasonal content.
- **Editorial content**: Blog posts, news articles, style guides.
