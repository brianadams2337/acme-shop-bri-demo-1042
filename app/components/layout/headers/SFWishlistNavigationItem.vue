<template>
  <SFLocalizedLink
    :to="routeList.wishlist"
    raw
    class="flex h-full items-center justify-center hover:bg-white/10"
    data-testid="wishlist-link"
    :aria-label="ariaLabel"
  >
    <IconCommerceWishlist class="size-5 shrink-0" />
    <span
      v-if="showLabel"
      class="ml-1.5 hidden text-sm lg:inline"
    >
      {{ $t('navigation.wishlist_label') || 'Wish List' }}
    </span>
    <span
      v-else
      class="ml-1 min-w-[1ch] text-sm font-semibold leading-none"
      data-testid="header-wishlist-count"
    >
      <template v-if="mounted && count">
        {{ count }}
      </template>
    </span>
  </SFLocalizedLink>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useMounted } from '@vueuse/core'
import { useI18n } from '#i18n'
import { useWishlist } from '#storefront/composables'
import SFLocalizedLink from '~/components/SFLocalizedLink.vue'
import { routeList } from '~/utils'
import { IconCommerceWishlist } from '#components'

defineProps<{ showLabel?: boolean }>()

const mounted = useMounted()
const { count } = useWishlist()
const i18n = useI18n()
const ariaLabel = computed(() =>
  i18n.t('navigation.wishlist', mounted.value ? count.value || 0 : 0),
)
</script>
