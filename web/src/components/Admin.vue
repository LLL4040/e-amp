<template>
  <el-container style="border: 0 solid #eee">
    <el-header style="padding-left: 0">
      <section class="text-white tm-font-big tm-parallax">
        <nav class="navbar navbar-expand-md tm-navbar scroll" id="tmNav">
          <div class="container">
            <div class="tm-next">
              <router-link router-link :to="{ name:'Login' }" class="navbar-brand">E-AMP</router-link>
            </div>
          </div>
        </nav>
      </section>
    </el-header>
    <el-container style="padding-top: 20px">
      <el-aside width="160px" style="background-color: rgb(238, 241, 246)">
        <el-menu :default-active="'1'" style="height:85vh;width:160px;float:left;overflow-y:auto">
          <div align="center">
            <i class="fas fa-3x fa-user-circle text-center tm-icon"></i>
            <div style="clear:both"></div>
            <el-button id="logout" type="success" plain size="mini" icon="el-icon-info">管理员</el-button>
          </div>
          <el-menu-item index="1" @click="toPage(1)">
            <i class="el-icon-s-custom"></i><span slot="title" style="font-size: 16px">管理活动室</span>
          </el-menu-item>
          <el-menu-item index="2" @click="toPage(2)">
            <i class="el-icon-warning"></i><span slot="title" style="font-size: 16px">待处理请求</span>
          </el-menu-item>
        </el-menu>
      </el-aside>
      <el-main style="height: 85vh;">
        <component :is="tabView"></component>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import page1 from './Activities.vue'
import page2 from './Requests.vue'
export default {
  name: 'Admin',
  data () {
    return {
      tabView: 'page1'
    }
  },
  mounted () {
  },
  methods: {
    toPage (id) {
      this.tabView = `page${id}`
    }
  },
  components: {
    page1,
    page2
  }
}
</script>

<style scoped>

</style>
