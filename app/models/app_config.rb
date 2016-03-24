# class AppConfig < ActiveRecord::Base
class AppConfig < ActiveRecord::Base
  def self.refresh_sidebar_mark
    first_or_create(sidebar_mark: generate_sidebar_mark)
  end

  def self.sidebar_mark
    first.try(:sidebar_mark)
  end

  def self.valid_sidebar_mark?(mark)
    return false if first.try(sidebar_mark) != mark
    true
  end

  def self.generate_sidebar_mark
    SecureRandom.base64(20)
    # better way: with keystring...
    # lambda { Digest::SHA256.base64digest 'key_string' }.call
  end
end
