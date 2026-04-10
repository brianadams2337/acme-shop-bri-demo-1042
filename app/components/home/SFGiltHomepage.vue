<template>
  <div class="gilt-homepage flex flex-col gap-1.5 p-1.5">
    <!-- Hero Section -->
    <section class="relative">
      <a href="/c/boutique-streams/260412-lagence-starting-at-60-off-432" class="block">
        <div class="relative w-full overflow-hidden">
          <img
            src="/images/gilt_1.png"
            alt="L'AGENCE Starting at 60% Off"
            class="h-auto w-full object-cover transition-transform duration-300 hover:scale-[1.02]"
          />
        </div>
      </a>
    </section>

    <!-- Promo Tiles Grid - Row 1 -->
    <section class="grid grid-cols-1 gap-1.5 md:grid-cols-2 lg:grid-cols-3">
      <!-- Tile 1 -->
      <a href="/c/boutique-streams/260408-best-finds-go-first-423" class="group relative block overflow-hidden">
        <img
          src="/images/gilt_2.png"
          alt="Extra 20% Off"
          class="h-auto w-full object-cover transition-transform duration-300 group-hover:scale-[1.03]"
        />
        <div class="absolute inset-0 bg-black/0 transition-colors duration-300 group-hover:bg-black/10" />
      </a>

      <!-- Tile 2 -->
      <a href="/c/boutique-streams/260402-its-all-75-off-on-women-429" class="group relative block overflow-hidden">
        <img
          src="/images/gilt_3.png"
          alt="Everything 82% Off"
          class="h-auto w-full object-cover transition-transform duration-300 group-hover:scale-[1.03]"
        />
        <div class="absolute inset-0 bg-black/0 transition-colors duration-300 group-hover:bg-black/10" />
      </a>

      <!-- Tile 3 -->
      <a href="/c/boutique-streams/260408-reiss-starting-at-60-off-430" class="group relative block overflow-hidden">
        <img
          src="/images/gilt_5.png"
          alt="Gilt Unlimited Annual"
          class="h-auto w-full object-cover transition-transform duration-300 group-hover:scale-[1.03]"
        />
        <div class="absolute inset-0 bg-black/0 transition-colors duration-300 group-hover:bg-black/10" />
      </a>
    </section>

    <!-- Promo Tiles Grid - Row 2 -->
    <section class="grid grid-cols-1 gap-1.5 md:grid-cols-2 lg:grid-cols-3">
      <!-- Tile 4 -->
      <a href="/c/boutique-streams/260407-the-watches-shop-434" class="group relative block overflow-hidden">
        <img
          src="/images/gilt_6.png"
          alt="Stuart Weitzman to Alexandre Birman 60% Off"
          class="h-auto w-full object-cover transition-transform duration-300 group-hover:scale-[1.03]"
        />
        <div class="absolute inset-0 bg-black/0 transition-colors duration-300 group-hover:bg-black/10" />
      </a>

      <!-- Tile 5 -->
      <a href="/p/gilt-unlimited-annual-113" class="group relative block overflow-hidden">
        <img
          src="/images/gilt_7.png"
          alt="Featured Collection"
          class="h-auto w-full object-cover transition-transform duration-300 group-hover:scale-[1.03]"
        />
        <div class="absolute inset-0 bg-black/0 transition-colors duration-300 group-hover:bg-black/10" />
      </a>

      <!-- Tile 6 -->
      <a href="/" class="group relative block overflow-hidden">
        <img
          src="/images/gilt_8.png"
          alt="New Arrivals"
          class="h-auto w-full object-cover transition-transform duration-300 group-hover:scale-[1.03]"
        />
        <div class="absolute inset-0 bg-black/0 transition-colors duration-300 group-hover:bg-black/10" />
      </a>
    </section>
  </div>
</template>

<script setup lang="ts">
defineOptions({ name: 'SFGiltHomepage' })
</script>
