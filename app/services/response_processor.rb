class ResponseProcessor
  def process(response, entity, mapping = {})
    return entity.new(map(response, mapping)) if response.is_a?(Hash)

    if response.is_a?(Array)
      response.map { |h| entity.new(map(h, mapping)) if h.is_a?(Hash) }
    end
  end

  def map(params, mapping = {})
    return params if mapping.empty?

    params.each_with_object({}) do |(k, v), hash|
      hash[mapping[k] ? mapping[k] : k] = v
    end
  end
end