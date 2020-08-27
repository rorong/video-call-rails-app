class BlogService
  include RequestLogger

  def initialize(environment = 'development')
    @env = environment
  end

  def posts
    url = "#{config.base_url}/posts"

    log_request('BlogService', url)
    posts = request_handler.send_request(url)
    response_processor.process(posts, Post, mapping)
  end

  def post(id)
    url = "#{config.base_url}/posts/#{id}"

    log_request('BlogService', url)
    posts = request_handler.send_request(url)
    response_processor.process(posts, Post, mapping)    
  end

  private

  attr_reader :env

  def config
    @config ||= BlogServiceConfig.new(env: @env)
  end

  def request_handler
    @request_handler ||= RequestHandler.new
  end

  def response_processor
    @response_processor ||= ResponseProcessor.new
  end

  def mapping
    { 'id' => :id, 'userId' => :user_id, 'body' => :body, 'title' => :title }
  end
end