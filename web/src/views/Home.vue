<template>
  <div class="home">
    <login msg="Welcome to Your Vue.js App"/>
  </div>
</template>

<script>
import login from '../components/Login.vue'

export default {
  name: 'Home',
  components: {
    login
  }
}
</script>
