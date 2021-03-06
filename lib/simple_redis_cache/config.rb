module SimpleRedisCache
  module Config
    def config(&block)
      instance_exec(&block)
    end

    def vector_cache(options, &block)
      name = options[:name]
      params = options[:params] || []
      caller = options[:caller]
      model = options[:model]
      raise 'vector_cache 缺少 name 参数'   if name.blank? 
      raise 'vector_cache 缺少 caller 参数' if caller.blank?
      raise 'vector_cache 缺少 model 参数'  if model.blank?

      vector_cache = SimpleRedisCache::VectorCacheDslParser.new(name, params, caller, model)
      vector_cache.instance_exec(vector_cache, &block)
      vector_cache.register
    end

    def value_cache(options, &block)
      name = options[:name]
      params = options[:params] || []
      caller = options[:caller]
      raise 'value_cache 缺少 name 参数'   if name.blank? 
      raise 'value_cache 缺少 caller 参数' if caller.blank?

      value_cache = SimpleRedisCache::ValueCacheDslParser.new(name, params, caller)
      value_cache.instance_exec(value_cache, &block)
      value_cache.register
    end
  end
end