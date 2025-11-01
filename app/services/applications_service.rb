class ApplicationsService
  def self.list
    Application.pluck(:name, :token, :chats_count).map do |name, token, chats_count|
      { name: name, token: token, chats_count: chats_count }
    end
  end

  def self.find_by_token(token)
    app = Application.find_by!(token: token)
    { name: app.name, token: app.token, chats_count: app.chats_count }
  end

  def self.create(name)
    token = SecureRandom.hex(16)
    PersistApplicationJob.perform_later(name, token)
    { name: name, token: token, chats_count: 0 }
  end

  def self.update(token, name)
    app = Application.find_by!(token: token)
    app.update!(name: name)
    { name: app.name, token: app.token, chats_count: app.chats_count }
  end
end