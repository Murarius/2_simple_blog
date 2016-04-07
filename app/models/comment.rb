class Comment < ActiveRecord::Base
  require 'action_view'
  require 'action_view/helpers'
  include ActionView::Helpers::DateHelper

  belongs_to :post

  validates :author, presence: true
  validates :post, presence: true
  validates :content, presence: true

  def as_json(options = {})
    { id: id, author: author, content: content, created_at: time_ago_in_words(created_at) + ' ago' }
  end
end
