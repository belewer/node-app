const express = require('express')
const app = express()
const port = 3000

// app.use(express.static('/app/my-app/dist/my-app'))

app.get('/', (req, res) => {
//   res.sendFile('/app/my-app/dist/my-app/index.html')
    res.send('<h1>Hello node app example</h1>')
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

