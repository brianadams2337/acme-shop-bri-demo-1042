<template>
  <SFButton
    variant="raw"
    listbox-button-aria-id="compact-shop-switcher"
    :aria-label="
      $t('shop_selector.aria_label', {
        selectedCountry,
        selectedLanguage,
      })
    "
    aria-haspopup="true"
    :aria-expanded="isOpen"
    class="flex items-center gap-1.5 text-sm text-white hover:text-white/80"
    data-testid="compact-shop-switcher"
    @click="openShopSwitcher"
  >
    <span class="whitespace-nowrap">{{ selectedCountry }}</span>
    <IconNavigationDown
      class="size-2.5 transition-all"
      :class="{ 'rotate-180': isOpen }"
    />
  </SFButton>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useCurrentShop } from '#storefront/composables'
import { SFButton } from '#storefront-ui/components'
import { useSlideIn } from '~~/modules/ui/runtime/composables/useSlideIn'
import { useCurrentShopTranslators } from '~/composables/useCurrentShopTranslators'
import { IconNavigationDown } from '#components'
import { useGlobalEvents } from '#tracking/composables'

const currentShop = useCurrentShop()

const { isOpen, toggle } = useSlideIn('ShopSwitcherSlideIn')
const { trackContentView } = useGlobalEvents()

const { languageTranslator, regionTranslator } = useCurrentShopTranslators()

const openShopSwitcher = () => {
  toggle()
  trackContentView({
    page: {
      interaction_source: 'change_shop_flyout',
    },
  })
}

const selectedLanguage = computed(() => {
  if (!currentShop.value) {
    return
  }
  const [language] = currentShop.value.locale.split('-')
  return languageTranslator.value?.of(language!)
})

const selectedCountry = computed(() => {
  if (!currentShop.value) {
    return
  }
  const [, region] = currentShop.value.locale.split('-')

  return region ? regionTranslator.value?.of(region) : null
})
</script>
