<template>
  <div>
    <div style="padding-top: 20px;">
      <el-card class="box-card">
        <el-table :data="requestData" style="width: 100%">
          <el-table-column prop="id" label="活动id" align="center"></el-table-column>
          <el-table-column prop="user" label="举报人用户名" align="center"></el-table-column>
          <el-table-column prop="content" label="举报原因" align="center"></el-table-column>
          <el-table-column label="操作" width="300px" align="center">
            <template slot-scope="scope">
              <el-button size="mini" type="primary" plain @click="openIt(scope.row)">查看活动室</el-button>
              <el-button size="mini" type="danger" plain @click="handleIt(scope.row)">关闭活动室</el-button>
              <el-button size="mini" type="info" plain @click="ignoreIt(scope.row)">忽略</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-card>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Requests',
  data () {
    return {
      requestData: []
    }
  },
  mounted () {
    this.initWebsocket()
  },
  destroyed () {
    this.wsocket.close()
  },
  methods: {
    initWebsocket () {
      const url = 'ws://202.120.40.8:30401/websocket/api/accusation'
      this.wsocket = new WebSocket(url)
      this.wsocket.onopen = this.onOpen
      this.wsocket.onmessage = this.onMessage
      this.wsocket.onerror = this.onError
      this.wsocket.onclose = this.onClose
    },
    onOpen () {
      const joinMsg = {}
      joinMsg.type = 'join'
      joinMsg.user = localStorage.getItem('user')
      const jsonstr = JSON.stringify(joinMsg)
      this.wsocket.send(jsonstr)
      window.console.log('connect to ws.')
    },
    onError () {
      window.console.log('connect error')
    },
    onMessage (evt) {
      const msg = JSON.parse(evt.data)
      const warnMsg = {}
      warnMsg.user = msg.user
      warnMsg.id = msg.id
      warnMsg.content = msg.content
      this.requestData.push(warnMsg)
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
    },
    openIt (row) {
      const { href } = this.$router.resolve({
        path: '/room',
        query: {
          user: localStorage.getItem('user'),
          id: row.id
        }
      })
      window.open(href, '_blank')
    },
    handleIt (row) {
      const url = '/api/close'
      const param = {
        params: {
          id: row.id
        }
      }
      this.$axios.get(url, param).then(response => {
        if (response.data.status === 1) {
          this.$alert('封禁成功！')
          this.ignoreIt(row)
        }
      })
    },
    ignoreIt (row) {
      this.requestData.some((item, i) => {
        if (item.id === row.id) {
          this.requestData.splice(i, 1)
          return true
        }
      })
    }
  }
}
</script>

<style scoped>

</style>
