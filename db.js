const Pool = require('pg').Pool;
const pool = new Pool({
    user: "postgres",
    password: "postgres",
    host: "localhost",
    port: 5432,
    database: "film_hm2"
});

module.exports = pool;