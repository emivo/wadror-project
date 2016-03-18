class AddAttachmentPhotoToProducts < ActiveRecord::Migration
  def change
    change_table :products do |p|
      p.attachment :photo
    end
  end
end
