require_relative 'lib/load_path'
require 'post'
require 'db_connection'
require 'sinatra'
require 'padrino-helpers'
require 'rack-flash'

enable :sessions
set :per_page, 20

Sinatra.register Padrino::Helpers
use Rack::Flash

get "/" do
  page = params[:page].try(:to_i) || 1
  @posts = Post.visible.order_by([:date, :desc]).skip( (page-1)*20 ).limit(settings.per_page)
  @posts.instance_eval do
    def num_of_page
      (Post.visible.length / settings.per_page.to_f).ceil.to_i
    end
  end
  erb :index
end

post "/mark_hide/:id" do
  @post = Post.find(params[:id])
  @post.update_attributes(:visible => false)
  flash[:notice] = "Successfully hide post #{@post.subject}. id #{@post.id}"
  redirect "/?page=#{params[:page]}"
end