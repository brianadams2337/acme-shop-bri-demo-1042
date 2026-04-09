<template>
  <div
    v-if="item?.children?.length"
    class="flex bg-white px-10 py-6"
    data-testid="desktop-navigation-flyout"
  >
    <!-- Categories Section -->
    <div class="flex gap-10">
      <!-- Left Column: Main Categories -->
      <div class="min-w-[140px]">
        <h3 class="mb-4 text-xs font-normal uppercase tracking-wider text-gray-500">
          Categories
        </h3>
        <ul class="flex flex-col space-y-1">
          <li
            v-for="columnItem in item.children"
            :key="columnItem.id"
            @mouseenter="activeCategory = columnItem"
          >
            <SFNavigationTreeItem
              :navigation-item="columnItem"
              :class="[
                'block w-full cursor-pointer rounded-sm px-3 py-1.5 text-sm transition-colors',
                activeCategory?.id === columnItem.id
                  ? 'bg-[#C9A227] text-white'
                  : isSpecialCategory(columnItem)
                    ? 'text-[#C9A227] hover:bg-gray-100'
                    : 'text-gray-800 hover:bg-gray-100',
              ]"
              raw
              @click="onItemClick(columnItem)"
            >
              {{ columnItem.name }}
            </SFNavigationTreeItem>
          </li>
        </ul>
      </div>

      <!-- Middle Column: Subcategories -->
      <div v-if="activeCategory?.children?.length">
        <ul class="flex flex-col space-y-1 pt-7">
          <li v-for="rowItem in activeCategory.children" :key="rowItem.id">
            <SFNavigationTreeItem
              :navigation-item="rowItem"
              class="block rounded-sm px-2 py-1.5 text-sm text-gray-700 transition-colors hover:bg-[#C9A227] hover:text-white"
              raw
              @click="onItemClick(rowItem)"
            >
              {{ rowItem.name }}
            </SFNavigationTreeItem>
          </li>
        </ul>
      </div>
    </div>

    <!-- Promo Section: Sales On Now -->
    <div v-if="promoData" class="ml-auto pl-10">
      <div class="mb-4 flex items-center justify-between">
        <h3 class="text-xs font-normal uppercase tracking-wider text-gray-500">
          Sales On Now
        </h3>
        <a
          href="#"
          class="text-xs text-gray-500 hover:text-gray-700"
          @click="emit('close')"
        >
          {{ promoData.viewAllLabel }}
        </a>
      </div>
      <div class="grid grid-cols-3 gap-1.5">
        <a
          v-for="promo in promoData.promos"
          :key="promo.id"
          :href="promo.link"
          class="block overflow-hidden transition-opacity hover:opacity-90"
          @click="emit('close')"
        >
          <img
            :src="promo.image"
            :alt="promo.title"
            class="size-64 object-cover"
          />
        </a>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import type { NavigationV2TreeItem } from '@scayle/storefront-nuxt'
import SFNavigationTreeItem from '~/components/layout/SFNavigationTreeItem.vue'

const props = defineProps<{ item: NavigationV2TreeItem }>()

const emit = defineEmits<{ close: [] }>()

const activeCategory = ref<NavigationV2TreeItem | null>(null)

const SPECIAL_CATEGORIES = ['clearance', 'sale', 'outlet']

const isSpecialCategory = (item: NavigationV2TreeItem) => {
  return SPECIAL_CATEGORIES.includes(item.name?.toLowerCase() ?? '')
}

const categoryPromos: Record<string, { viewAllLabel: string; promos: Array<{ id: number; image: string; title: string; link: string }> }> = {
  women: {
    viewAllLabel: 'View All Women',
    promos: [
      { id: 1, image: '/images/boutique_womens_1.png', title: 'Off-White™', link: '#' },
      { id: 2, image: '/images/boutique_womens_2.png', title: 'Best Finds', link: '#' },
      { id: 3, image: '/images/boutique_womens_3.png', title: 'Eileen Fisher', link: '#' },
      { id: 4, image: '/images/boutique_womens_4.png', title: '$31 for 31 Hours', link: '#' },
      { id: 5, image: '/images/boutique_womens_5.png', title: 'Reiss', link: '#' },
      { id: 6, image: '/images/boutique_womens_6.png', title: 'Italian Gold Shop', link: '#' },
    ],
  },
  men: {
    viewAllLabel: 'View All Men',
    promos: [
      { id: 1, image: '/images/boutique_mens_1.png', title: 'Mens Promo 1', link: '#' },
      { id: 2, image: '/images/boutique_mens_2.png', title: 'Mens Promo 2', link: '#' },
      { id: 3, image: '/images/boutique_mens_3.png', title: 'Mens Promo 3', link: '#' },
      { id: 4, image: '/images/boutique_mens_4.png', title: 'Mens Promo 4', link: '#' },
      { id: 5, image: '/images/boutique_mens_5.png', title: 'Mens Promo 5', link: '#' },
      { id: 6, image: '/images/boutique_mens_6.png', title: 'Mens Promo 6', link: '#' },
    ],
  },
  kids: {
    viewAllLabel: 'View All Kids',
    promos: [
      { id: 1, image: '/images/boutique_kids_1.png', title: 'Kids Promo 1', link: '#' },
      { id: 2, image: '/images/boutique_kids_2.png', title: 'Kids Promo 2', link: '#' },
      { id: 3, image: '/images/boutique_kids_3.png', title: 'Kids Promo 3', link: '#' },
      { id: 4, image: '/images/boutique_kids_4.png', title: 'Kids Promo 4', link: '#' },
      { id: 5, image: '/images/boutique_kids_5.png', title: 'Kids Promo 5', link: '#' },
      { id: 6, image: '/images/boutique_kids_6.png', title: 'Kids Promo 6', link: '#' },
    ],
  },
  home: {
    viewAllLabel: 'View All Home',
    promos: [
      { id: 1, image: '/images/boutique_home_1.png', title: 'Home Promo 1', link: '#' },
      { id: 2, image: '/images/boutique_home_2.png', title: 'Home Promo 2', link: '#' },
      { id: 3, image: '/images/boutique_home_3.png', title: 'Home Promo 3', link: '#' },
      { id: 4, image: '/images/boutique_home_4.png', title: 'Home Promo 4', link: '#' },
      { id: 5, image: '/images/boutique_home_5.png', title: 'Home Promo 5', link: '#' },
      { id: 6, image: '/images/boutique_home_6.png', title: 'Home Promo 6', link: '#' },
    ],
  },
}

const promoData = computed(() => {
  const navName = props.item?.name?.toLowerCase() ?? ''
  return categoryPromos[navName] || null
})

onMounted(() => {
  if (props.item?.children?.length) {
    activeCategory.value = props.item.children[0]
  }
})

const onItemClick = (item: NavigationV2TreeItem) => {
  if (item?.customData?.disabledLink) {
    return
  }
  emit('close')
}
</script>
