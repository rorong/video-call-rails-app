class Post
  attr_reader :id, :user_id, :body, :title

  def initialize(id:, user_id:, body:, title:)
    @id = id
    @user_id = user_id
    @body = body
    @title = title
  end
end