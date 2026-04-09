<template>
  <header
    class="relative flex h-15 items-center justify-between bg-black px-7 text-md font-semibold text-white"
  >
    <SFLocalizedLink
      :to="routeList.home"
      raw
      class="flex items-center gap-2 rounded-md p-1 text-md font-semibold text-white hover:text-white/80"
    >
      <IconNavigationBack class="size-4" data-testid="back-to-shop-button" />
      <div class="mr-auto hidden pt-0.5 md:block">
        {{ $t('global.back_to_shop') }}
      </div>
      <div class="mr-auto block pt-0.5 md:hidden">
        {{ $t('global.to_shop') }}
      </div>
    </SFLocalizedLink>

    <SFLocalizedLink
      :to="routeList.home"
      raw
      class="absolute left-1/2 -translate-x-1/2 text-white"
      :aria-label="shopName"
    >
      <IconLogoSignet class="h-9 w-auto" />
    </SFLocalizedLink>

    <nav class="hidden flex-row gap-4 md:flex">
      <SFNavigationTreeItem
        v-for="navItem in headerTree?.items"
        :key="`footer-link-${navItem.id}`"
        raw
        class="rounded-md p-1 text-white hover:text-white/80"
        :navigation-item="navItem"
      />
      <span class="ml-auto" />
    </nav>
  </header>
</template>

<script setup lang="ts">
import { useNuxtApp } from '#app/nuxt'
import SFLocalizedLink from '~/components/SFLocalizedLink.vue'
import { routeList } from '~/utils/route'
import { useNavigationsByReferenceKey } from '#storefront-navigation/composables'
import SFNavigationTreeItem from '~/components/layout/SFNavigationTreeItem.vue'
import { createCacheFriendlyTimestamp } from '~/utils'
import { IconLogoSignet, IconNavigationBack } from '#components'

const {
  $config: {
    public: { shopName },
  },
} = useNuxtApp()

const { data: headerTree } = useNavigationsByReferenceKey(
  {
    params: {
      referenceKey: 'checkout_header',
      visibleAt: createCacheFriendlyTimestamp(),
    },
  },
  'checkout-header',
)
</script>
