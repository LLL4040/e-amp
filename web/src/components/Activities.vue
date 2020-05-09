<template>
  <div>
    <div style="padding-top: 20px;">
      <el-card class="box-card">
        <el-table :data="activityData" style="width: 100%">
          <el-table-column type="expand">
            <template slot-scope="props">
              <el-form label-position="left" class="demo-table-expand">
                <el-form-item label="开始时间">
                  <span>{{ props.row.start }}</span>
                </el-form-item>
                <el-form-item label="结束时间">
                  <span>{{ props.row.end }}</span>
                </el-form-item>
                <el-form-item label="人数上限">
                  <span>{{ props.row.num }}</span>
                </el-form-item>
                <el-form-item label="已参加人数">
                  <span>{{ props.row.joined }}</span>
                </el-form-item>
                <el-form-item label="地点">
                  <span>{{ props.row.location }}</span>
                </el-form-item>
                <el-form-item label="标签">
                  <span>{{ props.row.tags }}</span>
                </el-form-item>
                <el-form-item label="描述">
                  <span>{{ props.row.description }}</span>
                </el-form-item>
              </el-form>
            </template>
          </el-table-column>
          <el-table-column prop="id" label="活动id" align="center"></el-table-column>
          <el-table-column prop="name" label="名称" align="center"></el-table-column>
          <el-table-column prop="sponsor" label="发起人" align="center"></el-table-column>
          <el-table-column label="活动状态" align="center">
            <template slot-scope="scope">
              <el-button v-if="scope.row.status === 0" type="success" plain size="small">未开始</el-button>
              <el-button v-if="scope.row.status === 1" type="info" plain size="small">已结束</el-button>
              <el-button v-if="scope.row.status === 2" type="danger" plain size="small">被封禁</el-button>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="300px" align="center">
            <template slot-scope="scope">
              <el-button size="mini" type="primary" plain @click="openIt(scope.row)">查看活动室</el-button>
              <el-button size="mini" type="danger" plain @click="handleIt(scope.row)">关闭活动室</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-card>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Activities',
  data () {
    return {
      activityData: []
    }
  },
  mounted () {
    this.loadData()
  },
  methods: {
    loadData () {
      const url = '/api/activities'
      this.$axios.get(url).then(response => {
        this.activityData = response.data
      })
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
          this.loadData()
          // this.activityData.some((item, i) => {
          //   if (item.id === row.id){
          //     this.activityData.splice(i, 1)
          //     return true
          //   }
          // })
        }
      })
    }
  }
}
</script>

<style scoped>

</style>
