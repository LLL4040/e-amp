<template>
  <!-- Hero section -->
  <section id="hero" class="text-white tm-font-big tm-parallax">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-md tm-navbar" id="tmNav">
      <div class="container">
        <div class="tm-next">
          <router-link router-link :to="{ name:'Login' }" class="navbar-brand">E-AMP</router-link>
        </div>
      </div>
    </nav>
    <div class="text-center tm-hero-text-container">
      <div class="tm-hero-text-container-inner" style="padding-left: 15%; padding-top: 11%">
      <el-card class="box-card" style="width: 882px;">
        <el-container>
          <el-aside style="text-align: left; height: 480px; width: 200px; padding-top: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px; border: 1px solid #eee">
            <div style="font-size: 16px; margin-top: 8px; margin-left: 12px;">聊天成员</div>
            <div style="font-size: 16px; margin-top: -4px; margin-left: 12px;">-----------------------</div>
            <div style="font-size: 14px; margin-left: 12px;" v-for="item in userList">{{ item }}</div>
          </el-aside>
          <el-container>
            <el-main style="height: 350px; padding-top: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px; border: 1px solid #eee">
              <div v-for="item in content">
                <p v-if="item.type === 0" style="text-align: left; font-size: 12px; margin-left: 16px; margin-bottom: 0px; color: #909399">{{ item.user }}说:</p>
                <p v-if="item.type === 0" style="text-align: left; font-size: 14px; margin-left: 16px; margin-bottom: 8px; color: #303133">{{ item.msg }}</p>
                <p v-if="item.type === 1" style="text-align: right; font-size: 12px; margin-right: 16px; margin-bottom: 0px; color: #909399">{{ item.user }}说:</p>
                <p v-if="item.type === 1" style="text-align: right; font-size: 14px; margin-right: 16px; margin-bottom: 8px; color: #303133">{{ item.msg }}</p>
              </div>
            </el-main>
            <el-footer style="padding-top: 0px; height: 100px; width: 660px; border: 0px solid #eee" align="right">
              <el-input type="textarea" :rows="3" placeholder="请输入内容，不能超过300字符" v-model="textarea" maxlength="300" resize="none">
              </el-input>
              <el-button type="primary" size="small" @click="sendMessage()">发送</el-button>
            </el-footer>
          </el-container>
        </el-container>
      </el-card>
    </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'Room',
  data () {
    return {
      id: 0,
      user: '', // 用户名
      textarea: '', // 输入消息
      userList: [], // 聊天成员
      wsocket: null, // Websocket connection
      content: [] // 聊天内容
    }
  },
  mounted () {
    this.getParams()
  },
  destroyed () {
    this.wsocket.close()
  },
  methods: {
    getParams () {
      // 取到路由带过来的参数
      this.user = this.$route.query.user
      this.id = this.$route.query.id
      this.initWebsocket()
    },
    initWebsocket () {
      const url = 'ws://202.120.40.8:30401/websocket/api/room/' + this.id
      this.wsocket = new WebSocket(url)
      this.wsocket.onopen = this.onOpen
      this.wsocket.onmessage = this.onMessage
      this.wsocket.onerror = this.onError
      this.wsocket.onclose = this.onClose
    },
    onOpen () {
      const joinMsg = {}
      joinMsg.type = 'join'
      joinMsg.user = this.user
      const jsonstr = JSON.stringify(joinMsg)
      this.wsocket.send(jsonstr)
      window.console.log('connect to ws.')
    },
    onError () {
      window.console.log('connect error')
    },
    onMessage (evt) {
      const msg = JSON.parse(evt.data)
      if (msg.type === 'users') {
        this.userList = msg.users
        console.log(this.userList)
      } else if (msg.type === 'talk') {
        const chatMsg = {}
        chatMsg.user = msg.user
        chatMsg.msg = msg.content
        if (msg.user === this.user) {
          chatMsg.type = 1
        } else {
          chatMsg.type = 0
        }
        this.content.push(chatMsg)
        console.log(this.content)
      } else if (msg.type === 'end') {
        this.$alert('活动已结束！')
        this.wsocket.close()
      } else {

      }
    },
    sendMessage () {
      if (this.textarea.length > 0) {
        const chatMsg = {}
        chatMsg.type = 'talk'
        chatMsg.user = this.user
        chatMsg.content = this.textarea.replace(/(\r\n|\n|\r)/gm, '')
        this.wsocket.send(JSON.stringify(chatMsg))
        this.textarea = ''
      } else {
        this.$alert('发送消息内容不能为空！')
      }
    },
    onClose (e) {
      window.console.log('connect close', e)
    }
  }
}
</script>

<style>
  p{
    width: 610px;
    overflow-wrap: break-word;
  }
</style>
