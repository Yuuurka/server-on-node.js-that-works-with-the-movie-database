const express = require('express');
const userRouter = require('./routes/film.routes');
const PORT = process.env.PORT || 3000;
const app = express();

app.use(express.json());
app.use('/api', userRouter);

app.listen(PORT, () => console.log(`SERVER IS RUNNING, ${PORT}`));
