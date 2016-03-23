# class AppConfig < ActiveRecord::Base
class AppConfig < ActiveRecord::Base
  def self.refresh_sidebar_mark
    first.update(sidebar_mark: generate_sidebar_mark)
  end

  def self.generate_sidebar_mark
    SecureRandom.base64(20)
    # better way: with keystring...
    # lambda { Digest::SHA256.base64digest 'key_string' }.call
  end
end
