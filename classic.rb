require_relative 'lib/load_path'
require 'post'
require 'db_connection'
require 'sinatra'
require 'padrino-helpers'
require 'rack-flash'

enable :sessions

Sinatra.register Padrino::Helpers
use Rack::Flash

get "/" do
  @posts = Post.visible.order_by([:date, :desc])
  erb :index
end

post "/mark_hide/:id" do
  @post = Post.find(params[:id])
  @post.update_attributes(:visible => false)
  flash[:notice] = "Successfully hide post #{@post.subject}. id #{@post.id}"
  redirect "/"
end