<template>
  <div class="relative">
    <!-- Main Header Bar (Black) -->
    <header
      class="flex h-13 items-center bg-header-bg lg:relative lg:h-16"
      data-testid="header"
    >
      <SFButton
        variant="raw"
        class="shrink-0 px-4 text-white lg:hidden"
        data-testid="side-navigation-button"
        :aria-label="$t('navigation.a11ly.side_navigation')"
        @click="isSideNavigationOpen = !isSideNavigationOpen"
      >
        <template #icon>
          <IconNavigationClose v-if="isSideNavigationOpen" class="size-5" />
          <IconNavigationMenu v-else class="size-6" />
        </template>
      </SFButton>

      <SFSlideInFromLeftTransition>
        <SFMobileSidebar
          v-popover="isSideNavigationOpen"
          class="absolute top-13 !m-0 h-[calc(100dvh-52px)] w-screen bg-white !p-0"
          :class="{
            'block-scrolling': isSideNavigationOpen,
            hidden: !isSideNavigationOpen,
          }"
          :is-open="isSideNavigationOpen"
          :navigation-items="mainNavigationItems"
          @close="isSideNavigationOpen = false"
        />
      </SFSlideInFromLeftTransition>

      <!-- Left 50%: Logo + Search -->
      <div class="flex w-1/2 items-center max-lg:hidden">
        <SFLogoLink
          data-testid="header-logo"
          class="shrink-0 px-4"
          @click="isSideNavigationOpen = false"
        />
        <SFSearchInput
          id="search-desktop"
          class="grow"
          data-testid="search-desktop"
        />
      </div>

      <!-- Mobile: Just logo -->
      <SFLogoLink
        data-testid="header-logo-mobile"
        class="px-4 lg:hidden"
        @click="isSideNavigationOpen = false"
      />

      <!-- Right 50%: Country, Wishlist, Account, Cart, Checkout -->
      <div class="flex h-full w-1/2 items-center justify-end text-white max-lg:grow">
        <SFShopSwitcherCompact class="px-3 max-lg:hidden" />
        <SFWishlistNavigationItem
          show-label
          class="px-2"
          @click="isSideNavigationOpen = false"
        />
        <SFUserNavigationItem
          show-label
          class="px-2"
          :block-popup="isSideNavigationOpen"
          @click="isSideNavigationOpen = false"
        />
        <SFBasketNavigationItem
          show-label
          class="px-2"
          :block-popup="isSideNavigationOpen || isBasketPage"
          @click="isSideNavigationOpen = false"
        />
        <SFLocalizedLink
          :to="routeList.basket"
          raw
          class="hidden h-full bg-gold px-6 text-sm font-semibold text-black hover:bg-gold/90 lg:flex lg:items-center"
          data-testid="checkout-button"
        >
          {{ $t('basket_page.checkout') || 'Checkout' }}
        </SFLocalizedLink>
      </div>
    </header>

    <!-- Navigation Bar (Black) -->
    <nav
      class="hidden h-10 bg-black lg:block"
      data-testid="nav-categories"
    >
      <div class="flex h-full items-center justify-center">
        <ul class="flex h-full items-center gap-8">
          <SFHeaderNavigationItem
            v-for="item in mainNavigationItems"
            :key="item.id"
            :item="item"
          />
        </ul>
      </div>
    </nav>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { whenever } from '@vueuse/core'
import SFLogoLink from '../../SFLogoLink.vue'
import SFLocalizedLink from '../../SFLocalizedLink.vue'
import SFUserNavigationItem from './SFUserNavigationItem.vue'
import SFBasketNavigationItem from './SFBasketNavigationItem.vue'
import SFWishlistNavigationItem from './SFWishlistNavigationItem.vue'
import SFSearchInput from './search/SFSearchInput.vue'
import SFMobileSidebar from './SFMobileSidebar.vue'
import SFHeaderNavigationItem from './SFHeaderNavigationItem.vue'
import SFShopSwitcherCompact from './shopSwitcher/SFShopSwitcherCompact.vue'
import { vPopover } from '~~/modules/ui/runtime/directives/popover'
import { routeList, createCacheFriendlyTimestamp } from '~/utils'
import {
  SFButton,
  SFSlideInFromLeftTransition,
} from '~~/modules/ui/runtime/components'
import { useNavigationsByReferenceKey } from '#storefront-navigation/composables'
import { useDefaultBreakpoints } from '~~/modules/ui/runtime'
import { useLocalePath } from '#i18n'
import { useRoute } from '#app/composables/router'
import { IconNavigationMenu } from '#components'

const isSideNavigationOpen = defineModel('isMobileSidebarOpen', {
  type: Boolean,
  default: false,
})

const route = useRoute()
const localePath = useLocalePath()

const { greaterOrEqual } = useDefaultBreakpoints()
const isDesktopLayout = greaterOrEqual('lg')

whenever(isDesktopLayout, () => {
  isSideNavigationOpen.value = false
})

const isBasketPage = computed(() => route.path === localePath(routeList.basket))

const { data: navigationTree } = useNavigationsByReferenceKey(
  {
    params: {
      referenceKey: 'header',
      with: { category: true },
      visibleAt: createCacheFriendlyTimestamp(),
    },
  },
  'header',
)

const mainNavigationItems = computed(() => navigationTree.value?.items)
</script>
