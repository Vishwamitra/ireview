#!/usr/bin/env python

from email.mime import image
from enum import unique
from unittest import result
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
import os

app = Flask(__name__)

basedir = os.path.abspath(os.path.dirname(__file__))

# database config
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'db.sqlite')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

#init my cool db
db = SQLAlchemy(app)

#init sweet marshmallow
ma=Marshmallow(app)


# product model class
class Product(db.Model):
    __tablename__ = 'product'
    prod_id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(20), unique=True)
    name = db.Column(db.String(200))
    description = db.Column(db.String(1000))
    summary = db.Column(db.Text)
    price = db.Column(db.Float)
    vat = db.Column(db.Float)
    image = db.Column(db.String)

    def __init__(self, prod_id, code, name, description, summary, price, vat, image):
        self.prod_id = prod_id
        self.code = code
        self.name = name
        self.description = description
        self.summary = summary
        self.price = price
        self.vat = vat
        self.image = image


# product review model class
class ProductReview(db.Model):
    __tablename__ = 'productreview'
    id = db.Column(db.Integer, primary_key=True)
    prod_id = db.Column(db.Integer, db.ForeignKey('product.prod_id'))
    reviewer = db.Column(db.String(100))
    price_quality = db.Column(db.Integer)
    user_experience = db.Column(db.Integer)
    summary = db.Column(db.Text)
    description = db.Column(db.Text)
    date_modified = db.Column(db.DateTime, server_default=db.func.now())

    def __init__(self, prod_id, reviewer, price_quality, user_experience, summary, description):
        self.prod_id = prod_id
        self.reviewer = reviewer
        self.price_quality = price_quality
        self.user_experience = user_experience
        self.description = description
        self.summary = summary
        


# Product class Schema to serealize
class ProductSchema(ma.Schema):
  class Meta:
    fields = ('id', 'prod_id', 'code', 'name', 'description', 'summary', 'price', 'vat')

# Product Review class Schema to serealize
class ProductReviewSchema(ma.Schema):
  class Meta:
    fields = ('prod_id', 'reviewer', 'price_quality', 'user_experience', 'description', 'summary')

# Initialize the schemas
product_schema = ProductSchema() # for single prodcut
products_schema = ProductSchema(many=True)  # for multiple products
product_review_schema = ProductReviewSchema() # always multiple reviews
product_reviews_schema = ProductReviewSchema(many=True) # always multiple reviews


# list all the products
@app.route('/products' , methods=['GET'])
def get_products():
    products = Product.query.all()
    result = products_schema.dump(products)
    return jsonify(result)


# get product details for a single product id
@app.route('/product/<prod_id>' , methods=['GET'])
def get_product(prod_id):
    product = Product.query.get(prod_id)
    result = product_schema.dump(product)
    return jsonify(result)


# get product reviews for a single product id
@app.route('/product/<prod_id>/reviews' , methods=['GET'])
def get_productreviews(prod_id):
    reviews = ProductReview.query.filter_by(prod_id=prod_id).all()
    result = product_reviews_schema.dump(reviews)
    return jsonify(result)


# Create a Product
@app.route('/product', methods=['POST'])
def new_product():
    prod_id = request.json['prod_id']
    code = request.json['code']
    name = request.json['name']
    description = request.json['description']
    summary = request.json['summary']
    price = request.json['price']
    vat = request.json['vat']
    image = request.json['image']
    new_product = Product(prod_id, code,name, description, summary, price, vat, image)
    db.session.add(new_product)
    db.session.commit()
    return product_schema.jsonify(new_product)


# Create a review for a Product
@app.route('/review/<prod_id>', methods=['POST'])
def new_product_review(prod_id):
    prod_id = prod_id
    reviewer = request.json['reviewer']
    price_quality = request.json['price_quality']
    user_experience = request.json['user_experience']
    summary = request.json['summary']
    description = request.json['description']
    new_product_review = ProductReview(prod_id, reviewer, price_quality, user_experience, summary, description)
    db.session.add(new_product_review)
    db.session.commit()
    return product_review_schema.jsonify(new_product_review)


if __name__=='__main__':
    app.run(debug=True)