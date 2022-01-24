import express from 'express'
import mysql from 'mysql'
const router = express.Router()

const connection = mysql.createPool({
	connectionLimit: 10,
	host: process.env.MYSQL_HOST || 'localhost',
	user: process.env.MYSQL_USER || 'root',
	password: process.env.MYSQL_PASSWORD || 'password',
	database: process.env.MYSQL_DATABASE || 'test'
})

const QUERY_PRODUCTS = 'SELECT P.*, IFNULL(AvgReview, 0) as AvgReview FROM PRODUCT P LEFT JOIN (SELECT ProductID as FakeID, ROUND(AVG(ReviewPriceQuality)/2) as AvgReview FROM REVIEW GROUP BY ProductID) AS R ON P.ProductID  = R.FakeID'

router.get('/products', (req, res) => {
	connection.query(QUERY_PRODUCTS, (err, rows) => {
		if(err){ 
            console.log(err)
            return res.json()
		} 
     
		res.json(rows)
	})
})

router.get('/product/:id', (req, res) => {
    const { id } = req.params

	connection.query(`${QUERY_PRODUCTS} WHERE ProductID = ?`, [id], (err, productInfo) => {
		connection.query(`SELECT * FROM REVIEW WHERE ProductID = ?`, [id], (err2, reviews) => {
            if(err || err2){ 
                console.log(err, err2)
                return res.json()
            }

            return res.json({
                ...productInfo[0],
                reviews
            })
        })
	})
})

router.post('/review', (req, res) => {
    const {
        ProductID,
        ReviewPriceQuality,
        Reviewer,
        ReviewSummary,
        ReviewDescription
    } = req.body

    connection.query(`
        INSERT INTO REVIEW (
        ProductId,
        ReviewPriceQuality,
        Reviewer,
        ReviewSummary,
        ReviewDescription) VALUES (?, ?, ?, ?, ?)`, [
            ProductID,
            ReviewPriceQuality,
            Reviewer,
            ReviewSummary,
            ReviewDescription
        ], (err, productInfo) => {
            connection.query(`SELECT * FROM REVIEW WHERE ReviewID = ?`, [productInfo.insertId], (err, finalInfo) => {
                if (err){
                    console.log(err)
                    return res.json()
                }

                return res.json(finalInfo[0])
            })
	    }
    )
})

router.get('/review/delete/:id', (req, res) => {
    const { id } = req.params
    connection.query(`DELETE FROM REVIEW WHERE ReviewID = ?`, [id], (err, reviews) => {
        if (err){
            console.log(err)
            return res.json()
        }

        return res.json()
    })
})

module.exports = router