class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates :url, url: true

  def gist?
    URI.parse(url).host == 'gist.github.com'
  end

  def gist_id
    url.split('/').last if gist?
  end

  def gist_content
    GistClient.new.content(gist_id).first
  end
end
