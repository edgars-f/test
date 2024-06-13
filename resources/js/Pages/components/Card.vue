<template>
  <div
    class="py-3 px-5 sm:py-4 flex items-center space-x-3 hover:bg-gray-50">
    <div class="flex-shrink-0">
      <img class="w-14 h-14 rounded" :src="character.image" :alt="character.name + ' image'" />
    </div>
    <div class="flex-1 min-w-0">
      <div class="text-sm font-semibold text-gray-900 truncate">
        {{ character.name }}
      </div>
      <p class="truncate pe-2">
        <svg class="w-4 h-4 text-gray-400 inline" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
          width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
          <path fill-rule="evenodd"
            d="M11.906 1.994a8.002 8.002 0 0 1 8.09 8.421 7.996 7.996 0 0 1-1.297 3.957.996.996 0 0 1-.133.204l-.108.129c-.178.243-.37.477-.573.699l-5.112 6.224a1 1 0 0 1-1.545 0L5.982 15.26l-.002-.002a18.146 18.146 0 0 1-.309-.38l-.133-.163a.999.999 0 0 1-.13-.202 7.995 7.995 0 0 1 6.498-12.518ZM15 9.997a3 3 0 1 1-5.999 0 3 3 0 0 1 5.999 0Z"
            clip-rule="evenodd" />
        </svg>

        <span class="text-xs text-gray-500 ms-1">{{ character.location.name }}</span>
      </p>
      <p>
        <svg class="w-4 h-4 text-gray-400 inline" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
          width="24" height="24" fill="currentColor" viewBox="0 0 24 24">
          <path fill-rule="evenodd"
            d="M19.003 3A2 2 0 0 1 21 5v2h-2V5.414L17.414 7h-2.828l2-2h-2.172l-2 2H9.586l2-2H9.414l-2 2H3V5a2 2 0 0 1 2-2h14.003ZM3 9v10a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V9H3Zm2-2.414L6.586 5H5v1.586Zm4.553 4.52a1 1 0 0 1 1.047.094l4 3a1 1 0 0 1 0 1.6l-4 3A1 1 0 0 1 9 18v-6a1 1 0 0 1 .553-.894Z"
            clip-rule="evenodd" />
        </svg>
        <span class="text-xs text-gray-500 ms-1">
          Appeared in {{ character.episode_count }}
          {{ character.episode_count === 1 ? 'Episode' : 'Episodes' }}
        </span>
      </p>
    </div>

    <span :class="[
      'inline-flex items-center text-xs font-medium px-2.5 py-0.5 rounded',
      {
        'bg-green-100 text-green-800': character.status === 'Alive',
        'bg-red-100 text-red-800': character.status === 'Dead',
        'bg-gray-100 text-gray-800': character.status === 'unknown',
      },
    ]">
      <span :class="[
        'w-2 h-2 me-1 rounded-full',
        {
          'bg-green-500': character.status === 'Alive',
          'bg-red-500': character.status === 'Dead',
          'bg-gray-500': character.status === 'unknown',
        },
      ]"></span>
      {{ character.status }}
    </span>
  </div>

</template>

<script>
export default {
  props: {
    character: {
      type: Object,
      required: true
    }
  }
}
</script>