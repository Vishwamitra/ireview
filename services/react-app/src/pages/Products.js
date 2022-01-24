import React from 'react'
import axios from 'axios'
import { NavLink } from 'react-router-dom'

class Component extends React.Component {

    state = {
        isLoading: true,
        products: []
    }

    componentDidMount(){
        axios.get(`http://localhost:${process.env.REACT_APP_PORT}/products`).then(response => {
            this.setState({
                isLoading: false,
                products: response.data
            })
        }).catch(error => console.error(error))
    }

    render(){
        if (this.state.isLoading) return <div className="loader"></div>

        return <div id="page_products"> 
            {
                this.state.products.map((product, i) => {
                    return <NavLink key={i} className='product' to={`product/${product.ProductID}`}>
                        <div className='product-image' style={{backgroundImage: `url(assets/product-cover-${product.ProductID}.png)`}}> </div>
                        <h3 className='title'> {product.ProductName} </h3>
                        <div className='stars'> 
                            { Array.from(Array(product.AvgReview).keys()).forEach((star, j) => {
                                    return <img key={j} className='star' src='images/star.png' />
                                })
                            }
                        </div>
                        <h4 className='summary'> {product.ProductSummary} </h4>
                        <h5> ${product.ProductPrice} </h5>
                    </NavLink>
                })
            }
        </div>
    }
}

export default Component