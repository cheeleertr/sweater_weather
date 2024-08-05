class UserSerializer
  include JSONAPI::Serializer

  def self.format_user(user)
    {
      data: {
        type: "users",
        id: user.id,
        attributes: {
          email: user.email,
          api_key: user.api_keys.first.token
        }
      }
    }
  end
end