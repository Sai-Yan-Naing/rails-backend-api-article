module Api
	module V1
		class ArticlesController < ApplicationController
			def index
				articles = Article.all;
				render json: {status: 'SUCCESS', message: 'Index Articles', data:articles},status: :ok
			end

			def show
				article = Article.find(params[:id])
				render json: {status: 'SUCCESS', message: 'Show article', data:article},status: :ok
			end

			def create
				title = params[:title]
				body = params[:body]
				article = Article.new()
				article.title=title
				article.body=body
				if article.save
					render json: {status: 'SUCCESS', message: 'Save', data:article},status: :ok
				else
					render json: {status: 'ERROR', message: 'Article not saved', data:article.errors},status: :unprocessable_entity 
				end
			end

			def update
				article = Article.find(params[:id])
				title = params[:title]
				body = params[:body]
				if article.update(title: title, body: body)
					render json: {status: 'SUCCESS', message: 'updated'},status: :ok
				else
					render json: {status: 'ERROR', message: 'Article not updated', data:article.errors},status: :unprocessable_entity 
				end
			end

			def destroy
				article = Article.find(params[:id])
				article.destroy
				render json: {status: 'SUCCESS', message: 'DELETE', data:article},status: :ok
			end

			private

			def article_params
				params.permit(:title, :body)
			end

		end
	end
end