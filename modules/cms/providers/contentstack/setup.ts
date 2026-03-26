import {
  addComponentsDir,
  addPlugin,
  addTypeTemplate,
  createResolver,
} from '@nuxt/kit'
import type { Nuxt } from '@nuxt/schema'
import {
  getContentstackEndpoints,
  getRegionForString,
} from '@timbenniks/contentstack-endpoints'
import type { ModuleOptions } from '../../types'
import { logger } from '../../utils/helpers'
import { CMSProvider } from '../../utils/config'
import type {
  ContentstackModuleOptions,
  ContentstackRuntimeConfig,
} from './types'

export const setupContentstack = (_options: ModuleOptions, nuxt: Nuxt) => {
  const resolver = createResolver(import.meta.url)
  logger.info('Using Contentstack as Storefront CMS provider')

  const runtimeCMS = nuxt.options.runtimeConfig?.public
    .cms as unknown as ContentstackRuntimeConfig

  // Validate required configuration
  if (
    runtimeCMS.accessToken === undefined &&
    !import.meta.env.NUXT_PUBLIC_CMS_ACCESS_TOKEN
  ) {
    logger.error('Missing Contentstack accessToken')
  }

  if (
    runtimeCMS.deliveryAccessToken === undefined &&
    !import.meta.env.NUXT_PUBLIC_CMS_DELIVERY_TOKEN
  ) {
    logger.error('Missing Contentstack deliveryToken')
  }

  if (
    runtimeCMS.previewAccessToken === undefined &&
    !import.meta.env.NUXT_PUBLIC_CMS_PREVIEW_TOKEN
  ) {
    logger.error('Missing Contentstack previewToken')
  }

  if (
    runtimeCMS.environment === undefined &&
    !import.meta.env.NUXT_PUBLIC_CMS_ENVIRONMENT
  ) {
    logger.error('Missing Contentstack environment')
  }

  if (
    runtimeCMS.region === undefined &&
    !import.meta.env.NUXT_PUBLIC_CMS_REGION
  ) {
    logger.error('Missing Contentstack region')
  }

  const region = getRegionForString(runtimeCMS.region)
  if (!region) {
    logger.error('Invalid region')
  }

  nuxt.options.build = nuxt.options.build || {}
  nuxt.options.build.transpile = nuxt.options.build.transpile || []

  // Transpile Contentstack packages for ESM support
  const contentstackPackages = [
    '@contentstack/core',
    '@contentstack/utils',
    '@contentstack/delivery-sdk',
    '@contentstack/live-preview-utils',
    'lodash',
  ]

  contentstackPackages.forEach((dep) => {
    if (!nuxt.options.build.transpile.includes(dep)) {
      nuxt.options.build.transpile.push(dep)
    }
  })

  addPlugin(resolver.resolve('./runtime/plugins/contentstackClient'))

  nuxt.options.alias['#storefront-cms/components'] =
    resolver.resolve('./components')

  nuxt.options.alias['#storefront-cms/utils'] =
    resolver.resolve('./utils/utils')

  addComponentsDir({
    path: resolver.resolve('./components'),
    pathPrefix: false,
  })

  addTypeTemplate({
    filename: 'cms-generated.d.ts',
    src: resolver.resolve('./types/gen/contentstack.d.ts'),
  })

  addTypeTemplate({
    filename: 'cms-types.d.ts',
    src: resolver.resolve('./types/index.ts'),
  })

  addTypeTemplate({
    filename: 'storefront-cms.d.ts',
    write: true,
    getContents: () => {
      return `
      import { ContentstackRuntimeConfig } from '${resolver.resolve(
        './types/index.ts',
      )}'
      declare module '@nuxt/schema' {
        interface RuntimeConfig {
          cms: ContentstackRuntimeConfig
        }
        interface PublicRuntimeConfig {
          cms: ContentstackRuntimeConfig
        }
      }
      declare module '#build/cms-generated' {
        export interface SystemFields {
          $: Record<string, object>
        }
      }
      export {}
      `
    },
  })
}

/**
 * Type guard to check if the CMS module options are for Contentstack.
 *
 * @param options - The CMS module options to check
 * @returns `true` if the provider is Contentstack, `false` otherwise
 */
export function isProviderContentstack(
  options: ModuleOptions,
): options is ContentstackModuleOptions {
  return options.provider === CMSProvider.CONTENTSTACK
}

export async function setupContentstackImageProvider(nuxt: Nuxt) {
  const region = getRegionForString(
    nuxt.options.runtimeConfig?.public.cms.region,
  )
  const endpoints = getContentstackEndpoints(region, true)
  const contentstackCdnDomain = endpoints.images || 'images.contentstack.io'

  nuxt.options.image.domains ??= []

  if (!nuxt.options.image.domains.includes(contentstackCdnDomain)) {
    nuxt.options.image.domains.push(contentstackCdnDomain)
  }

  const resolver = createResolver(import.meta.url)
  nuxt.options.image.providers.contentstack ??= {
    name: 'contentstack',
    provider: resolver.resolve('./runtime/imageprovider/index.ts'),
    options: {
      baseURL: contentstackCdnDomain,
      modifiers: {
        quality: '85',
        format: 'avif',
      },
    },
  }
}
