<template>
  <!-- Hero section -->
  <section id="hero" class="text-white tm-font-big tm-parallax">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-md tm-navbar" id="tmNav">
      <div class="container">
        <div class="tm-next">
<!--          <img src="../../public/img/logo.gif" width="60px">-->
          <router-link router-link :to="{ name:'Login' }" class="navbar-brand">E-AMP</router-link>
        </div>
      </div>
    </nav>
    <div class="text-center tm-hero-text-container">
      <div class="tm-hero-text-container-inner" style="padding-left: 32%; padding-top: 13%">
        <el-card class="box-card" style="width: 55%">
          <div slot="header" class="clearfix" style="margin-bottom: -20px;">
            <i class="fas fa-2x fa-user-circle text-center tm-icon" style="float:left;"></i>
            <h3 class="text-center tm-text-primary mb-4" style="padding-top: 10px; font-size: 20px; float: left;">管理员登录</h3>
          </div>
          <el-form ref="form" :model="form" label-width="60px">
            <el-form-item label="用户名">
              <el-input v-model="form.name"></el-input>
            </el-form-item>
            <el-form-item label="密码">
              <el-input v-model="form.password" show-password></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="danger" plain @click="refresh()" style="float: right;">清空</el-button>
              <el-button type="primary" plain @click="login()" style="float: right;">登录</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Login',
  data () {
    return {
      flag: 0,
      form: {
        name: '',
        password: ''
      }
    }
  },
  methods: {
    login () {
      if (this.form.name === '' || this.form.password === '') {
        this.$alert('请输入完整信息！')
        return 0
      }
      const url = '/api/admin/login'
      const head = {
        headers: {
          'Content-Type': 'application/json;charset=UTF-8'
        }
      }
      const self = this
      this.$axios.post(url, this.form, head).then(response => {
        console.log(response.data.status)
        if (response.data.status === 1) {
          localStorage.setItem('user', self.form.name)
          self.$router.push({ name: 'Admin' })
        } else if (response.data.status === 0) {
          this.$alert(response.data.message)
        } else {
          this.$alert('登录失败！请重试！')
        }
      })
    },
    refresh () {
      this.form.name = ''
      this.form.password = ''
    }
  }
}
</script>

<style scoped>

</style>
