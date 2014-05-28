module MemcachesPage
  extend ActiveSupport::Concern
  module ClassMethods
    def memcaches_page(*actions)
      return unless perform_caching
      options = actions.extract_options!

      after_filter({:only => actions}.merge(options)) do |c|
        c.memcache_page
      end
    end

    def memcache_page(content, host, path, options={})
      puts "hit class method memcache_page"
      return unless perform_caching

      cache_path = host << path
      puts "attempting to write to cache"
      Rails.cache.write cache_path.gsub('%', '%25'), content, nil # options.merge(raw: true)
      puts "Dump of the cache"
      puts Rails.cache
    end
  end

  def memcache_page(options = {})
    puts "hit memcache_page instance method"
    return unless self.class.perform_caching && caching_allowed? && !request.params.key?('no-cache')
    puts "passed return on memcache_page instance method"
    self.class.memcache_page(response.body, request.host, request.fullpath, options)
  end
end


