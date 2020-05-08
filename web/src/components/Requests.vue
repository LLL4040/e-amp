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
      requestData: [
        {
          id: 1,
          user: '张三',
          content: '无'
        }
      ],
      handleR: {
        repairman: '',
        phone: ''
      }
    }
  },
  mounted () {
  },
  methods: {
    loadRequest () {
      const bodyFormData = new FormData()
      bodyFormData.set('communityId', this.userInfo.communityId)
      bodyFormData.set('pageNumber', this.pageNum)
      bodyFormData.set('pageSize', this.pageSize)
      const url = '/lifeservice-server/api/maintain/managerFindUnMaintain'
      this.$axios({
        method: 'post',
        url: url,
        data: bodyFormData,
        config: { headers: { 'Content-type': 'multipart/form-data' } }
      }
      ).then(response => {
        if (response.data.length > 0 && response.data[0].login === 0) {
          this.$router.push({ name: 'Login' })
        } else {
          this.requestData = response.data
          console.log(this.requestData)
          this.total = response.data[0].pageNum
        }
      })
    },
    openIt (row) {
      const { href } = this.$router.resolve({
        path: '/room',
        query: {
          user: this.user,
          id: row.id
        }
      })
      window.open(href, '_blank')
    },
    handleIt () {
      this.dialogFormVisible = false
      const bodyFormData = new FormData()
      bodyFormData.set('id', this.requestId)
      bodyFormData.set('status', 1)
      bodyFormData.set('maintainname', this.handleR.repairman)
      bodyFormData.set('phone', this.handleR.phone)
      bodyFormData.set('managername', this.userInfo.username)
      const url = '/lifeservice-server/api/maintain/manageMaintain'
      this.$axios({
        method: 'post',
        url: url,
        data: bodyFormData,
        config: { headers: { 'Content-type': 'multipart/form-data' } }
      }
      ).then(response => {
        if (response.data.login === 0) {
          this.$router.push({ name: 'Login' })
        } else {
          if (response.data.manageMaintain === '1') {
            this.loadRequest()
            this.$forceUpdate()
          } else {
            this.$alert('处理失败！')
          }
        }
      })
    },
    ignoreIt (row) {
    }
  }
}
</script>

<style scoped>

</style>
