class ApplicationController < ActionController::Base
  include MemcachesPage
  protect_from_forgery with: :exception
end
