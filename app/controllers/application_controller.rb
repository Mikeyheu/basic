class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include MemcachesPage

  # def cache_page(content = nil, options = nil, gzip = Zlib::BEST_COMPRESSION)
  #   path = "/#{request.host}"
  #   path << case options
  #   when Hash
  #     url_for(options.merge(:only_path => true, :skip_relative_url_root => true, :format => params[:format]))
  #   when String
  #     options
  #   else
  #     if request.path.empty? || request.path == '/'
  #       '/index'
  #     else
  #       request.path
  #     end
  #   end
  #   # super(content, path, gzip)
  #   Rails.cache.write path.gsub('%', '%25'), content, nil
  # end

  

end
