class CitationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :type, :subtype, :cite
  attributes :creators
  attributes :tags
  attribute :published_date, key: :published
  attributes :title, :subtitle, :place, :publisher
  attributes :links
  has_many :identifiers, serializer: IdentifierSerializer
  belongs_to :parent, serializer: CitationSerializer
  attributes :pages
  attributes :serie
  attribute :volume
  attribute :full_entry
  
  def type
    'Reference'
  end
  
  def subtype
    object.type
  end
  
  def links
    {
      self: api_citation_url(object, host: Rails.application.secrets.host),
      human: subject_url(object, host: Rails.application.secrets.host)
    }
  end
  
  def serie
    {
      name: object.serie.try(:name), abbr: object.serie.try(:abbr)
    }
  end
  
  def creators
    {
      type: object.creator_type, names: object.creators.map{|c| c.name}.join(', ')
    }
  end

  def tags
    object.tags.map{|c| c.name}.join(', ')
  end
    
  def place
    object.place.try(:name)
  end
  
  def publisher
    object.publisher.try(:name)
  end
  
  def pages
    if object.first_page.present? && object.last_page.present?
      "#{object.first_page}-#{object.last_page}"
    elsif object.page_count.present?
      object.page_count
    end
  end
  
end
