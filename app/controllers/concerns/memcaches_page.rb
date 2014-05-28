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
      return unless perform_caching
      cache_path = host << path
      logger.info "Writing to cache. Here's the cache_path: #{cache_path}"
      Rails.cache.write cache_path.gsub('%', '%25'), content, nil # options.merge(raw: true)
      logger.info "Cache stats --- : #{Rails.cache.stats}"
    end
  end

  def memcache_page(options = {})
    return unless self.class.perform_caching && caching_allowed? && !request.params.key?('no-cache')
    self.class.memcache_page(response.body, request.host, request.fullpath, options)
  end
end
