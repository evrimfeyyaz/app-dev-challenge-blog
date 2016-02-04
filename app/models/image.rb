class Image < ActiveRecord::Base
  has_attached_file :data,
                    styles: { thumb_2x: "700x" },
                    default_url: "/images/:style/missing.png"
  has_many :posts, dependent: :nullify

  validates_attachment_content_type :data, content_type: ["image/jpeg", "image/gif", "image/png"]
end