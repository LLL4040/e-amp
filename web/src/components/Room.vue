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
      <el-card class="box-card" style="text-align: left; width: 882px;">
        <el-container>
          <el-aside style="height: 470px; width: 200px; padding-top: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px; border: 0px solid #eee">
            <textarea readonly="true" style="resize: none; height: 460px; width: 190px;">{{ userList }}</textarea>
          </el-aside>
          <el-container>
            <el-main style="padding-top: 0px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px; border: 0px solid #eee">
              <textarea readonly="true" style="resize: none; height: 350px; width: 640px;">{{ content }}</textarea>
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
      userList: '', // 聊天成员
      wsocket: null, // Websocket connection
      content: '' // 聊天内容
    }
  },
  mounted () {
    this.getParams()
    this.initWebsocket()
  },
  destroyed () {
    this.wsocket.close()
  },
  methods: {
    getParams () {
      // 取到路由带过来的参数
      this.user = this.$route.query.user
      this.id = this.$route.query.id
    },
    initWebsocket () {
      const url = 'ws://localhost:8888/websocket'
      this.wsocket = new WebSocket(url)
      this.wsocket.onopen = this.onOpen
      this.wsocket.onmessage = this.onMessage
      this.wsocket.onerror = this.onError
      this.wsocket.onclose = this.onClose
    },
    onOpen () {
      const joinMsg = {}
      joinMsg.type = 'join'
      joinMsg.name = this.user
      const jsonstr = JSON.stringify(joinMsg)
      this.wsocket.send(jsonstr)
      window.console.log('connect to ws.')
    },
    onError () {
      window.console.log('connect error')
    },
    onMessage (evt) {
      let line = ''
      const msg = JSON.parse(evt.data)
      if (msg.type === 'chat') {
        line = msg.name + ': '
        if (msg.target.length > 0) {
          line += '@' + msg.target + ' '
        }
        line += msg.message + '\n'
        this.content += line
      } else if (msg.type === 'info') {
        line = '[--' + msg.info + '--]\n'
        this.content += line
      } else if (msg.type === 'users') {
        line = 'Users:\n'
        for (let i = 0; i < msg.userList.length; i++) { line += '-' + msg.userList[i] + '\n' }
        /* Update the user list area */
        this.userList = line
      }
    },
    sendMessage () {
      if (this.textarea.length > 0) {
        const chatMsg = {}
        chatMsg.type = 'chat'
        chatMsg.name = this.user
        chatMsg.target = this.getTarget(this.textarea.replace(/,/g, ''))
        chatMsg.message = this.cleanTarget(this.textarea)
        chatMsg.message = chatMsg.message.replace(/(\r\n|\n|\r)/gm, '')
        this.wsocket.send(JSON.stringify(chatMsg))
        this.textarea = ''
      } else {
        alert('发送消息内容不能为空！')
      }
    },
    onClose (e) {
      window.console.log('connect close', e)
    },
    getTarget (str) {
      const arr = str.split(' ')
      let target = ''
      for (let i = 0; i < arr.length; i++) {
        if (arr[i].charAt(0) === '@') {
          target = arr[i].substring(1, arr[i].length)
          target = target.replace(/(\r\n|\n|\r)/gm, '')
        }
      }
      return target
    },
    cleanTarget (str) {
      const arr = str.split(' ')
      let cleanstr = ''
      for (let i = 0; i < arr.length; i++) {
        if (arr[i].charAt(0) !== '@') { cleanstr += arr[i] + ' ' }
      }
      return cleanstr.substring(0, cleanstr.length - 1)
    }
  }
}
</script>

<style scoped>

</style>
