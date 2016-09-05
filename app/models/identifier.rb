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

      if data && data["items"]
        id = data["items"][0]["id"]
        link = data["items"][0]["volumeInfo"]["canonicalVolumeLink"]
        image = data["items"][0]["volumeInfo"].try(:[],'imageLinks').try(:[],'thumbnail')
        description = data["items"][0]["volumeInfo"].try(:[],'description')
        subject.update(g_volume_id: id, g_canonical_link: link, g_image_thumbnail: image, g_description: description )
      end
    end
  end
end