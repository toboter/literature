json.extract! subject, :id, :slug, :title, :subtitle, :type, :parent_id, :first_page, :last_page, :page_count, :volume, :published_date, :abbr, :edition, :language, :publisher_id, :place_id, :g_volume_id, :g_canonical_link, :g_image_thumbnail, :created_at, :updated_at
json.url subject_url(subject, format: :json)