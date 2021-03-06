
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end
  
  get '/articles/new' do 
      erb :new
  end 

  post '/articles' do 
    article = Article.create(params)
    redirect to "/articles/#{article.id}"
    binding.pry
  end

  get '/articles' do 
    @article = Article.all
    erb :index
  end

  get '/articles/:id' do
    @article = Article.find_by(id: params[:id]) 
    erb :show
  end

  get '/articles/:id/edit' do 
    
    @article = Article.find_by(id: params[:id])
    # binding.pry
    erb :edit
  end
  patch '/articles/:id' do
    id = params[:id]
    updates = {}
    @article = Article.find_by(id: params[:id])
    updates[:title]= params[:title]
    updates[:content] = params[:content]
    @article.update(updates)
    redirect to "/articles/#{id}"
  end

  delete '/articles/:id' do 
    @article = Article.find_by(id: params[:id])
    @article.delete
    redirect to '/articles'
  end 
end
