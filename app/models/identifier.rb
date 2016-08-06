class Identifier < ApplicationRecord
  require 'net/http'
  belongs_to :subject
  after_save :find_gvolume
  
  validates :ident_name, :ident_value, presence: true
  
  def self.ident_names
    %w(ISBN ISSN)
  end
  
  def find_gvolume # auslagern in job
    if ident_name == 'ISBN'
      source = "https://www.googleapis.com/books/v1/volumes?q=isbn:"+ident_value.gsub(/[^0-9a-z ]/i, '')
	    resp = Net::HTTP.get_response(URI.parse(source))
   	  data = JSON.parse(resp.body)

      if data
        subject.update(g_volume_id: data["items"][0]["id"],
          g_canonical_link: data["items"][0]["volumeInfo"]["canonicalVolumeLink"],
          g_image_thumbnail: data["items"][0]["volumeInfo"]["imageLinks"]["thumbnail"],
          g_description: data["items"][0]["volumeInfo"]["description"])
      end
    end
  end
end