class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true, touch: true

  validates :name, presence: true
  validates :url, url: true

  def gist?
    link = URI.parse(url)
    link.hostname == 'gist.github.com' && link.path&.length > 2
  end
end