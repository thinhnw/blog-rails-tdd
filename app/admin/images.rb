ActiveAdmin.register Image do
  remove_filter :image_attachment, :image_blob
  permit_params :name, :image

  index do
    selectable_column
    id_column
    column :name
    column "Image" do |i|
      image_tag image_path(i), height: 80, alt: i.name, title: i.name
    end
    column "Image Tag" do |i|
      "#{image_tag image_path(i), alt: i.name, title: i.name}"
    end
    actions
  end

  form do |f|
    hint = image_tag image_path(f.object),
                     height: 80,
                     alt: f.object.name,
                     title: f.object.name if f.object.persisted?
    f.inputs do
      f.input :name
      f.input :image, as: :file, hint:
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row "Image" do |i|
        image_tag image_path(i), height: 80, alt: i.name, title: i.name
      end
      row "Image Tag" do |i|
        "#{image_tag image_path(i), alt: i.name, title: i.name}"
      end
    end
  end
end
